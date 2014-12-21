# Развертывание приложения

* Установить node.js

* Установить coffee-script, bower, gulp, karma-cli и supervisor глобально.
```
npm install -g coffee-script bower gulp supervisor
```

* Установить npm зависимости
```
npm install
cd renderer
npm install
```

* Установить bower зависимости
```
bower install
```

* Создать пользователя в postgres для приложения
```
sudo -u postgres createuser top -s
sudo -u postgres psql
\password top
```

* Копируем файл .env.sample в .env и заполняем поля

* Ставим гемы
```
bundle install
```

* Создаем базу и накатываем миграции
```
rake db:create
rake db:migrate
RAILS_ENV=test rake db:create
RAILS_ENV=test rake db:migrate
```

* Компилируем css и js с помощью gulp
```
gulp
```

* Запускаем все (каждая команда в новой вкладке консоли)
```
rails s
foreman start renderer
gulp watch
guard
```

* Заходим на http://localhost:3000
