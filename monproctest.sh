#!/bin/bash

# Лог-файл
LOGFILE="/var/log/monproctest.log"

# Файл для хранения последнего PID
PIDFILE="/var/run/test_process.pid"

# URL для отправки запроса
API_URL="https://test.com/monitoring/test/api"

# Получаем текущий PID
current_pid=$(pgrep -f "test")

# Проверяем, запущен ли процесс
if [[ -z "$current_pid" ]]; then
  echo "$(date) - Процесс 'test' не запущен." >> "$LOGFILE"
  exit 0
fi

# Проверяем, существует ли файл с PID
if [[ ! -f "$PIDFILE" ]]; then
  # Первый запуск, сохраняем PID
  echo "$current_pid" > "$PIDFILE"
  echo "$(date) - Процесс 'test' запущен впервые (PID: $current_pid)." >> "$LOGFILE"

elif [[ $(cat "$PIDFILE") != "$current_pid" ]]; then
  # PID изменился, значит процесс был перезапущен
  old_pid=$(cat "$PIDFILE")
  echo "$current_pid" > "$PIDFILE"
  echo "$(date) - Процесс 'test' перезапущен. Старый PID: $old_pid, Новый PID: $current_pid" >> "$LOGFILE"

  # Отправляем запрос на API и обрабатываем ошибки
  echo "$(date) - Отправка запроса на $API_URL после перезапуска..." >> "$LOGFILE"
  curl -s -o /dev/null -w "%{http_code}\n" "$API_URL" > /tmp/curl_response 2>&1  # Перенаправляем stderr в stdout
  HTTP_CODE=$(cat /tmp/curl_response)
  rm /tmp/curl_response

  if [[ "$HTTP_CODE" -eq 200 ]]; then
    echo "$(date) - Запрос успешно отправлен. Код ответа: $HTTP_CODE" >> "$LOGFILE"
  elif [[ "$HTTP_CODE" == "" ]]; then # Проверка на пустой HTTP_CODE, что говорит об ошибке соединения
    echo "$(date) - Ошибка: Сервер мониторинга недоступен." >> "$LOGFILE"
  else
    echo "$(date) - Ошибка при отправке запроса. Код ответа: $HTTP_CODE" >> "$LOGFILE"
  fi
fi

# После сознания этого  скрипта, делаем этот скрипт исполняемым
# sudo chmod +x monproctest.sh
# записываем в хронтаб выполнение каждую минуту
# crontab -e
# В конец документа ставим * * * * *  и путь к файлу (/data/data/com.termux/files/home/anton/monproctest.sh)
