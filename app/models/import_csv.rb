class ImportCsv < ApplicationRecord
  # # CSVデータのパスを引数として受け取り、インポート処理を実行
  # def self.import(path)
  #    CSV.foreach(path, headers: true) do |row|
  #      User.create(
  #        name: row["name"],
  #        age: row["age"],
  #        address: row["address"]
  #      )
  #    end
  # end
  # CSVデータのパスを引数として受け取り、インポート処理を実行
  def self.users_data
    # インポートするファイルのパスを取得
    path = File.join Rails.root, "db/csv/csv_data.csv"
    # インポートするデータを格納するための配列
    list = []
    # CSVファイルからインポートするデータを取得し配列に格納
    CSV.foreach(path, headers: true) do |row|
      list << {
          name: row["name"],
          age: row["age"],
          address: row["address"]
      }
    end
    puts "インポート処理を開始"
    # インポートができなかった場合の例外処理
    begin
      User.create!(list)
      puts "インポート完了!!"
    rescue ActiveModel::UnknownAttributeError => invalid
      puts "インポートに失敗：UnknownAttributeError"
    end
  end
end
