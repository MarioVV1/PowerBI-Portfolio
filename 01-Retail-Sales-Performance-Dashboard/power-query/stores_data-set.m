// Power Query (M) for table: stores data-set
// Update the file path below to where you saved the CSV.
let
    Source = Csv.Document(File.Contents("C:\Users\pinna\Downloads\Retail_Data\Retail_Data\Retail_Data\stores data-set.csv"),[Delimiter=",", Columns=3, Encoding=874, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Store", Int64.Type}, {"Type", type text}, {"Size", Int64.Type}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Store", "Store"}, {"Size", "Store Size"}, {"Type", "Store Type"}})
in
    #"Renamed Columns"
