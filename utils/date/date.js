.pragma library

const months = ["Января", "Февраля", "Марта",
                "Апреля", "Мая", "Июня", "Июля", "Августа",
                "Сентября","Октября", "Ноября", "Декабря"];

const days = ["Воскресенье", "Понедельник", "Вторник",
              "Среда", "Четверг", "Пятница", "Суббота"];

function getObjectDate(){
    return new Date();
}
function getTime() {
    return getObjectDate().getTime().toLocaleString();
}

function getHours() {
    return getObjectDate().getHours();
}

function getMinutes() {
    return getObjectDate().getMinutes();
}

function getSeconds() {
    return getObjectDate().getSeconds();
}

function getDate() {
    return getObjectDate().getDate();
}

function getMonth() {
    return getObjectDate().getMonth();
}

function getMonthName() {
    return months[getObjectDate().getMonth()];
}

function getDayName() {
    return days[getObjectDate().getDay()];
}

function getYear() {
    return getObjectDate().getFullYear();
}

function getGreeting() {
    return `Сегодня ${getDate()} ${getMonthName()}, ${getDayName()}`;
}