
.pragma library
.import "../date/date.js" as DateUtils

function determinateTheTimeOfDay() {
    const hours = DateUtils.getHours();
    if (hours >= 4 && hours <= 11) {
        return "Доброе утро!";
    } else if (hours >= 12 && hours <= 16) {
        return "Добрый день!";
    } else if (hours >= 17 && hours <= 23) {
        return "Добрый вечер!";
    } else {
        return "Доброй ночи!";
    }    
}
