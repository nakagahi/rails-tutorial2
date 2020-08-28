# メインのサンプルユーザーを1人作成する
User.create!(name:  "中川 大樹",
             email: "iwbb1022@icloud.com",
             password:              "nh10221022",
             password_confirmation: "nh10221022",
             admin: true)

# 追加のユーザーをまとめて生成する
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
