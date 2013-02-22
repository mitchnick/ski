require 'smarter_csv'
class CsvDb
    class << self
        def convert_save(model_name, csv_file)
            target_model = model_name.classify.constantize
            
            # csv_array = SmarterCSV.process(csv_file.path, {:col_sep => "\,", :quote_char =>'"'})   # , :row_sep => "\cM"
            csv_array = SmarterCSV.process(csv_file.path)   # , :row_sep => "\cM"
            # TODO: Data - Fix how the "" marks are added for cells with commas in them. 
            csv_array.each do |a|
                if target_model.find_by_id(a[:id]) == nil               # Create new database entry
                    new_object = target_model.new
                    a.each do |key,value|
                        new_object[key] = value 
                    end
                    new_object.save
                else                                                    # Update Values
                    existing_object = target_model.find(a[:id])
                    a.each do |key, value|
                        existing_object[key] = value
                    end
                    existing_object.save
                end 
            end
        end
    end
end