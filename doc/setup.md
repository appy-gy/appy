# Развертывание приложения

* Установить node.js

* Установить глобальные зависимости.
```sh
npm install -g coffee-script nodemon webpack webpack-dev-server
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

* Ставим гемы
```sh
bundle install
```

* Создаем базу и накатываем миграции
```sh
rake db:create
rake db:migrate
```

* Запускаем
```sh
foreman start
```

* Заходим на http://localhost:9292
