<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IT Словарь</title>
    <style>
        :root {
            --bg-color: #f0f0f0;
            --text-color: #333;
            --card-bg: white;
            --shadow: rgba(0, 0, 0, 0.1);
            --button-bg: #4CAF50;
            --button-hover: #45a049;
        }

        .dark-mode {
            --bg-color: #1a1a1a;
            --text-color: #f0f0f0;
            --card-bg: #2d2d2d;
            --shadow: rgba(0, 0, 0, 0.3);
            --button-bg: #2E7D32;
            --button-hover: #1B5E20;
        }

        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: var(--bg-color);
            color: var(--text-color);
            transition: background 0.3s, color 0.3s;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        h1 {
            text-align: center;
            color: var(--text-color);
        }

        .controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 20px 0;
            flex-wrap: wrap;
            gap: 10px;
        }

        .nav-buttons {
            display: flex;
            gap: 10px;
        }

        button, .theme-toggle {
            padding: 10px 20px;
            cursor: pointer;
            background-color: var(--button-bg);
            color: white;
            border: none;
            border-radius: 5px;
            transition: background 0.3s;
        }

        button:hover, .theme-toggle:hover {
            background-color: var(--button-hover);
        }

        .search-sort {
            display: flex;
            gap: 10px;
        }

        #search {
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            width: 200px;
        }

        .cards-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }

        .card {
            background-color: var(--card-bg);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px var(--shadow);
            transition: transform 0.2s;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card h3 {
            color: var(--text-color);
            margin-top: 0;
        }

        .card p {
            color: var(--text-color);
            opacity: 0.9;
        }

        @media (max-width: 600px) {
            .controls {
                flex-direction: column;
            }
            .search-sort {
                width: 100%;
            }
            #search {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>IT Словарь</h1>
        
        <div class="controls">
            <div class="nav-buttons">
                <button onclick="showSlang()">Жаргон</button>
                <button onclick="showProfessional()">Профессиональные</button>
                <button onclick="sortAlphabetically()">А-Я</button>
            </div>
            
            <div class="search-sort">
                <input type="text" id="search" placeholder="Поиск..." oninput="searchTerms()">
                <button class="theme-toggle" onclick="toggleTheme()">🌓 Тёмная тема</button>
            </div>
        </div>

        <div id="content" class="cards-container"></div>
    </div>

    <script>
        // Жаргонные термины (40 примеров)
        const slangTerms = [
            { term: "Баг", definition: "Ошибка в программе или системе" },
            { term: "Фича", definition: "Функция, особенность программы" },
            { term: "Краш", definition: "Аварийное завершение программы" },
            { term: "Лаг", definition: "Задержка в работе системы" },
            { term: "Гит", definition: "Система контроля версий Git" },
            { term: "Релиз", definition: "Выпуск готовой версии продукта" },
            { term: "Дебажить", definition: "Искать и исправлять ошибки" },
            { term: "Код ревью", definition: "Проверка кода коллегами" },
            { term: "Мержить", definition: "Объединять ветки кода (merge)" },
            { term: "Патч", definition: "Небольшое обновление, исправление" },
            // Добавьте остальные 30 терминов...
        ];

        // Профессиональные термины (40 примеров)
        const professionalTerms = [
            { term: "API", definition: "Application Programming Interface - интерфейс программирования приложений" },
            { term: "СУБД", definition: "Система управления базами данных" },
            { term: "Алгоритм", definition: "Последовательность шагов для решения задачи" },
            { term: "Компилятор", definition: "Программа, переводящая код в машинный язык" },
            { term: "Инкапсуляция", definition: "Принцип ООП, скрытие реализации" },
            { term: "Кэш", definition: "Промежуточное хранилище данных" },
            { term: "Драйвер", definition: "Программа для управления устройством" },
            { term: "Рекурсия", definition: "Функция, вызывающая саму себя" },
            { term: "Фреймворк", definition: "Набор инструментов для разработки" },
            { term: "Бэкенд", definition: "Серверная часть приложения" },
            // Добавьте остальные 30 терминов...
        ];

        let currentTerms = [];
        let isDarkMode = false;

        // Поиск терминов
        function searchTerms() {
            const searchText = document.getElementById('search').value.toLowerCase();
            const filteredTerms = currentTerms.filter(term => 
                term.term.toLowerCase().includes(searchText) || 
                term.definition.toLowerCase().includes(searchText)
            );
            renderTerms(filteredTerms);
        }

        // Сортировка от А до Я
        function sortAlphabetically() {
            const sortedTerms = [...currentTerms].sort((a, b) => 
                a.term.localeCompare(b.term)
            );
            renderTerms(sortedTerms);
        }

        // Переключение темы
        function toggleTheme() {
            isDarkMode = !isDarkMode;
            document.body.classList.toggle('dark-mode', isDarkMode);
            localStorage.setItem('darkMode', isDarkMode);
        }

        // Загрузка темы из localStorage
        function loadTheme() {
            isDarkMode = localStorage.getItem('darkMode') === 'true';
            document.body.classList.toggle('dark-mode', isDarkMode);
        }

        // Отображение терминов
        function renderTerms(terms) {
            const container = document.getElementById('content');
            container.innerHTML = '';
            
            terms.forEach(term => {
                const card = document.createElement('div');
                card.className = 'card';
                card.innerHTML = `
                    <h3>${term.term}</h3>
                    <p>${term.definition}</p>
                `;
                container.appendChild(card);
            });
        }

        function showSlang() {
            currentTerms = slangTerms;
            renderTerms(slangTerms);
        }

        function showProfessional() {
            currentTerms = professionalTerms;
            renderTerms(professionalTerms);
        }

        // Инициализация
        window.onload = function() {
            loadTheme();
            showSlang(); // Показываем жаргон по умолчанию
        };
    </script>
</body>
</html>
