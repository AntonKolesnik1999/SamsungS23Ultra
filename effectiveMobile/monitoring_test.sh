#!/bin/bash

# Проверка наличия процесса "test"
current_pid=$(pgrep -x "test")

# Пути для хранения данных
PID_FILE="/var/run/monitoring_test.pid"
LOG_FILE="/var/log/monitoring.log"

# Проверка перезапуска процесса
if [ -n "$current_pid" ]; then
    if [ -f "$PID_FILE" ]; then
        previous_pid=$(cat "$PID_FILE")
        if [ "$current_pid" != "$previous_pid" ]; then
            echo "$(date "+%Y-%m-%d %H:%M:%S") - Процесс 'test' перезапущен. Новый PID: $current_pid" >> "$LOG_FILE"
        fi
    fi
    echo "$current_pid" > "$PID_FILE"

    # Отправка HTTP-запроса
    if ! curl -sSf --max-time 5 "https://test.com/monitoring/test/api" >/dev/null 2>&1; then
        echo "$(date "+%Y-%m-%d %H:%M:%S") - Сервер мониторинга недоступен" >> "$LOG_FILE"
    fi
else
    [ -f "$PID_FILE" ] && rm -f "$PID_FILE"
fi
