pragma Singleton
import QtQuick

// Единая тема виджета. Меняешь тут — меняется везде.
QtObject {
    // ---- Фон / карточки ----
    readonly property color bgCard: "#CC121321"
    readonly property color bgCardSolid: "#12131F"
    readonly property color bgTile: "#1A1C2E"
    readonly property color border: "#1A1C2E"
    readonly property color hoverBg: "#14FFFFFF"

    // ---- Акценты ----
    readonly property color accent: "#7C5CFC"
    readonly property color accentSoft: "#2A7C5CFC"
    readonly property color accentGradientStart: "#8B7CFC"
    readonly property color accentGradientEnd: "#5C7CFC"

    // ---- Текст ----
    readonly property color textPrimary: "#FFFFFF"
    readonly property color textSecondary: "#9A9CB5"
    readonly property color textMuted: "#5C5E78"

    // ---- Статусные цвета ----
    readonly property color colorDiscord: "#5865F2"
    readonly property color colorSystem: "#3B9EFF"
    readonly property color colorSpotify: "#1ED760"
    readonly property color colorGood: "#3ED598"
    readonly property color colorGpu: "#3BC7FF"
    readonly property color colorCpu: "#B98BFF"

    // ---- Радиусы ----
    readonly property int radiusLg: 24
    readonly property int radiusMd: 16
    readonly property int radiusSm: 10

    // ---- Отступы ----
    readonly property int spacingLg: 20
    readonly property int spacingMd: 14
    readonly property int spacingSm: 8
    readonly property int cardPadding: 20

    // ---- Прочее ----
    readonly property string textNoData: "Нет данных"

    // ---- Шрифты ----
    readonly property string fontFamily: "Inter"

    readonly property var _glyphs: ({
        "home": "⌂",
        "notifications": "🔔",
        "cloud": "☁",
        "desktop_windows": "🖥",
        "calendar_month": "📅",
        "settings": "⚙",
        "power_settings_new": "⏻",
        "more_vert": "⋮",
        "chevron_left": "‹",
        "chevron_right": "›",
        "expand_more": "⌄",
        "thermostat": "🌡",
        "water_drop": "💧",
        "air": "💨",
        "favorite": "♥",
        "favorite_border": "♡",
        "skip_previous": "⏮",
        "skip_next": "⏭",
        "play_arrow": "▶",
        "pause": "⏸",
        "volume_up": "🔊",
        "chat": "💬",
        "music_note": "♪",
        "partly_cloudy_day": "⛅",
        "sunny": "☀",
        "rainy": "🌧"
    })

    // Возвращает Unicode-символ по семантическому имени глифа.
    // Если имя не найдено — возвращает "?", а не мусорный текст.
    function glyph(name) {
        return _glyphs.hasOwnProperty(name) ? _glyphs[name] : "?"
    }
}
