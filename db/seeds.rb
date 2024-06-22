# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Admin.create!(
#    # email: "admins@admins",
#    password: "adminspass"
# )

Apple = User.find_or_create_by!(email: "apple@example.com") do |user|
   user.name = "Apple"
   user.password = "password"
   user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

Mikan = User.find_or_create_by!(email: "mikan@example.com") do |user|
   user.name = "Mikan"
   user.password = "password"
   user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
end

Budou = User.find_or_create_by!(email: "budou@example.com") do |user|
   user.name = "Budou"
   user.password = "password"
   user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
end

Genre.create(name: '初めまして')

post = Post.find_or_create_by!(title: "こんにちは!!") do |post|
   post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
   post.body = "最近シングルマザーになりましたが周りに同じシンママ友達がいないので新しく登録しました。"
   post.user = Apple
end

post.genres << genre
post.save

Genre.create(name: 'お悩み・相談')

post = Post.find_or_create_by!(title: "いつも子どもとふたりの食事で疲れます") do |post|
   post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")
   post.body = "息抜きにランチできる友達か相談に乗ってくれる人を探しています"
   post.user = "Budou"
end

post.genres << genre
post.save

Genre.create(name: 'その他')

post = Post.find_or_create_by!(title: "最近植物を育てることにはまっています") do |post|
   post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg")
   post.body = "子どもも楽しんで育てています"
   post.user = "Mikan"
end

post.genres << genre
post.save

puts "seedの実行が完了しました"
