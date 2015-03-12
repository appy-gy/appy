# Развертывание приложения

* Установить node.js

* Установить coffee-script глобально.
```sh
npm install -g coffee-script
```

* Установить npm зависимости
```sh
npm install
```

* Создать пользователя в postgres для приложения
```sh
sudo -u postgres createuser top -s
sudo -u postgres psql
\password top
```

* Копируем файл .env.sample в .env и заполняем поля
```sh
cp .env.sample .env
```

* Копируем файл .env.sample.coffee в .env.coffee и заполняем поля
```sh
cp .env.sample.coffee .env.coffee
```

* Ставим гемы
```sh
bundle install
```

* Создаем базу и накатываем миграции
```sh
rake db:create
rake db:migrate
```

* Компилируем index.html
```sh
npm run index-html-dev
```

* Запускаем все (каждая команда в новой вкладке консоли)
```sh
rails s
npm run dev-server
npm run touch-sass
```

* Заходим на http://localhost:3000
