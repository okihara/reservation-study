require 'nokogiri'
require 'open-uri'
require 'json'

# コマンドラインからURLを取得
if ARGV.empty?
  puts "使用法: ruby script.rb <URL>"
  exit
end

url = ARGV[0]

# HTMLをダウンロード
html = URI.open(url).read

# Nokogiriでパース
doc = Nokogiri::HTML(html)

# 出勤情報を含むHTML要素を取得
staff_info_items = doc.css('.main_section_info_item')

staffs = []

# 各スタッフの情報を抽出
staff_info_items.each do |item|
  name = item.at_css('.main_section_info_name').text.strip
  size = item.at_css('.main_section_info_size').text.strip
  working_time = item.at_css('.main_section_info_working_text').text.strip

  staff_id = item.at_css('.main_section_info_inner')['href'].match(/id=(\d+)/)[1]

  # 写真のURLを取得
  photo_url = item.at_css('.main_section_info_img_object')['src']

  # 写真をダウンロード
  photo_filename = "karinto-#{staff_id}.jpg"
  URI.open(photo_url) do |photo|
    File.open('./public/images/' + photo_filename, 'wb') do |file|
      file.write(photo.read)
    end
  end

  # puts "名前: #{name}"
  # puts "サイズ: #{size}"
  # puts "出勤時間: #{working_time}"
  # puts "写真: #{photo_filename}"
  # puts "---"
  staffs.push({
                staff_id: staff_id,
                name: name,
                size: size,
                work_date: Time.now.strftime('%m/%d'),
                working_time: working_time.split('～'),
                photo_name: photo_filename
              })
end

puts JSON.dump({staffs: staffs})
# ruby scrape_karinto_fujo.rb "https://fujoho.jp/index.php?p=shop_info&id=43360&addDay=0"