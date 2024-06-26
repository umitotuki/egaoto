# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.find_or_create_by!(email: ENV['ADMINSMAIL']) do |admin|
  admin.password = ENV['ADMINSPASS']
end

apple = User.find_or_create_by!(email: "apple@example.com") do |user|
   user.name = "Apple"
   user.birth = "1990年10月22日"
   user.password = "password"
   user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

mikan = User.find_or_create_by!(email: "mikan@example.com") do |user|
   user.name = "Mikan"
   user.birth = "1995年04月15日"
   user.password = "password"
   user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
end

budou = User.find_or_create_by!(email: "budou@example.com") do |user|
   user.name = "Budou"
   user.birth = "1985年12月25日"
   user.password = "password"
   user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
end

test1 = User.find_or_create_by!(email: "test1@example.com") do |user|
   user.name = "フードバンクさくらんぼ"
   user.birth = "2019年5月〜"
   user.password = "password"
   user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user4.jpg"), filename:"sample-user4.jpg")
end

genre1 = Genre.create(name: '初めまして')

post = Post.find_or_create_by!(title: "こんにちは!!") do |post|
   post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
   post.body = "最近シングルマザーになりましたが周りに同じシンママ友達がいないので新しく登録しました。"
   post.user_id = apple.id
   post.genre_id = genre1.id
   post.is_draft = false
end

post.save

genre2 = Genre.create(name: 'お悩み・相談')

post = Post.find_or_create_by!(title: "いつも子どもとふたりの食事で疲れます") do |post|
   post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post4.jpg"), filename:"sample-post4.jpg")
   post.body = "息抜きにランチできる友達か相談に乗ってくれる人を探しています"
   post.user_id = budou.id
   post.genre_id = genre2.id
   post.is_draft = false
end

post.save

genre3 = Genre.create(name: 'その他')

post = Post.find_or_create_by!(title: "最近植物を育てることにはまっています") do |post|
   post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg")
   post.body = "子どもも楽しんで育てています"
   post.user_id = mikan.id
   post.genre_id = genre3.id
   post.is_draft = false
end

post.save

genre4 = Genre.create(name: '支援情報')

post = Post.find_or_create_by!(title: "◯月◯日に食料と衣類などの提供をします") do |post|
   post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post4.jpg"), filename:"sample-post4.jpg")
   post.body = "◯月◯日(日)、開催場所＊＊。親子で休憩できるスペースがあります。食料品などを持ち帰る袋はお持ちください。今月も沢山の方からご支援があり感謝しております。フードバンクさくらんぼ"
   post.user_id = test1.id
   post.genre_id = genre4.id
   post.is_draft = false
end

post.save

puts "seedの実行が完了しました"

