// Power Query (M) for table: sales data-set
// Update the file path below to where you saved the CSV.
let
    Source = Csv.Document(File.Contents("C:\Users\pinna\Downloads\Retail_Data\Retail_Data\Retail_Data\sales data-set.csv"),[Delimiter=",", Columns=5, Encoding=874, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Store", Int64.Type}, {"Dept", Int64.Type}, {"Date", type date}, {"Weekly_Sales", type number}, {"IsHoliday", type logical}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Weekly_Sales", "Weekly Sales"}}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Renamed Columns",{{"Dept", Int64.Type}})
in
    #"Changed Type1"
