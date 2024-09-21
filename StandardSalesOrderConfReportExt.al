reportextension 50100 StandardSalesOrderConf extends "Standard Sales - Order Conf."
{
    dataset
    {
        addlast(Line)
        {
            dataitem(PageBreakRepeater; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(EmtpyText; '') { }
                trigger OnPreDataItem()
                begin
                    if not PageBreakAfterLines then
                        CurrReport.Break();
                end;
            }
        }
        addbefore(AssemblyLine)
        {
            dataitem(LineWithoutPageBreak; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(DescriptionWithoutPageBreak; Line.Description) { }
                column(QuantityWithoutPageBreak; FormattedQuantity) { }
                column(UnitOfMeasureWithoutPageBreak; Line."Unit of Measure") { }
                column(UnitPriceWithoutPageBreak; FormattedUnitPrice) { }
                column(LineDiscountPercentTextWithoutPageBreak; LineDiscountPctText) { }
                column(LineAmountWithoutPageBreak; FormattedLineAmount) { }
                column(NoWithoutPageBreak; Line."No.") { }
                column(VATPctWithoutPageBreak; FormattedVATPct) { }
                trigger OnPreDataItem()
                begin
                    if PageBreakBeforeEachLine then
                        CurrReport.Break();
                end;
            }
            dataitem(LineWithPageBreak; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(DescriptionWithPageBreak; Line.Description) { }
                column(QuantityWithPageBreak; FormattedQuantity) { }
                column(UnitOfMeasureWithPageBreak; Line."Unit of Measure") { }
                column(UnitPriceWithPageBreak; FormattedUnitPrice) { }
                column(LineDiscountPercentTextWithPageBreak; LineDiscountPctText) { }
                column(LineAmountWithPageBreak; FormattedLineAmount) { }
                column(NoWithPageBreak; Line."No.") { }
                column(VATPctWithPageBreak; FormattedVATPct) { }
                trigger OnPreDataItem()
                begin
                    if not PageBreakBeforeEachLine then
                        CurrReport.Break();
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
            addlast(Options)
            {
                field(PageBreakBeforeEachLineControl; PageBreakBeforeEachLine)
                {
                    ApplicationArea = All;
                    Caption = 'Page break after each line';
                    ToolTip = 'Page break after each line';
                }
                field(PageBreakAfterLinesControl; PageBreakAfterLines)
                {
                    ApplicationArea = All;
                    Caption = 'Page break after Lines';
                    ToolTip = 'Page break after Lines';
                }
            }
        }

    }
    rendering
    {
        layout("StandardSalesOrderConf.docx")
        {
            Type = Word;
            LayoutFile = './StandardSalesOrderConf.docx';
            Caption = 'Conditional Page Break (Word)';
            Summary = 'Conditional Page Break (Word)';
        }

    }
    var
        PageBreakBeforeEachLine: Boolean;
        PageBreakAfterLines: Boolean;
}
