#!/bin/bash
if [ $# -ne 0 ]
then
echo 'Invald number of parameters'
exit 1
fi

if [ -d log ]
then
    rm -rf log
fi
mkdir log

status_codes=(200 201 400 401 403 404 500 501 502 503)
methods=(GET POST PUT PATCH DELETE)
agents=("Mozilla" "Google Chrome" "Opera" "Safari" "Internet Explorer" "Microsoft Edge" "Crawler and bot" "Library and net tool")
urls=("/index.php" "/index.php/read?id=11" "/index.php?kek=77" "/about.html" "/admin.html" "/dashboard.html" "/products.html" "/sales.html" "/services.html")


for ((day=1; day < 6; day++ )); do
    log_lines=`shuf -n1 -i 100-1000`
    day_begin=`date -u -d "2023-06-0$day 00:15:00" +"%s"`
    day_end=`date -u -d "2023-06-0$day 23:59:59" +"%s"`
    log_step=$(( (day_end - day_begin) / log_lines ))
    logfile="`realpath "log"`/access_log_$day.log"
    while [ $log_lines -ge 0 ]; do
        day_begin=$(( day_begin + (log_step - (RANDOM % 15)) ))
        printf "%s - - [%s +0000] \"%s %s HTTP/2\" %s %s  %s\n"\
            "`shuf -n1 -i 1-255`.`shuf -n1 -i 1-255`.`shuf -n1 -i 1-255`.`shuf -n1 -i 1-255`"\
            "`date -u -d @$day_begin +"%d/%b/%Y:%H:%M:%S"`"\
            "${methods[$((RANDOM % ${#methods[@]}))]}" "${urls[$RANDOM % ${#urls[@]}]}" "${status_codes[$((RANDOM % ${#status_codes[@]}))]}" \
            "${agents[$((RANDOM % ${#agents[@]}))]}" >> $logfile
        ((log_lines--))
    done
done

echo "Complete"
exit 0

# 200 - запрос успешно обработан
# 201 - успешно создан новый ресурс
# 400 - некорректный запрос
# 401 - неавторизованный доступ к ресурсу  
# 403 - доступ запрещен  
# 404 - ресурс не найден  
# 500 - внутренняя ошибка сервера  
# 501 - метод не поддерживается сервером  
# 502 - невозможно получить ответ от сервера, на который был передан запрос  
# 503 - сервис временно недоступен
