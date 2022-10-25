#Использовать "../internal"
#Использовать configor
#Использовать logos
#Использовать semaphore

Перем ИнициализированныеЖелудиОдиночки;
Перем Рогатки;
Перем ФабрикаЖелудей;
Перем СостояниеПриложения;
Перем НапильникиБылиПроинициализированы;

Перем Лог;
Перем МенеджерПараметров;

Функция ПолучитьОпределенияЖелудей() Экспорт
	Возврат ФабрикаЖелудей.ПолучитьОпределенияЖелудей();
КонецФункции

Функция ПолучитьОпределениеЖелудя(Имя) Экспорт
	Возврат ФабрикаЖелудей.ПолучитьОпределениеЖелудя(Имя);
КонецФункции

Функция НайтиЖелудь(Имя, ПрилепляемыеЧастицы = Неопределено) Экспорт
	
	Если ВРег(Имя) = ВРег("Поделка") Тогда
		ПроверитьСостояниеВыполнение();
		Возврат ЭтотОбъект;
	КонецЕсли;

	ОпределениеЖелудя = ФабрикаЖелудей.ПолучитьОпределениеЖелудя(Имя);

	Если НЕ ОпределениеЖелудя.ВремениИнициализации() Тогда
		ПроверитьСостояниеВыполнение();

		Если НЕ НапильникиБылиПроинициализированы Тогда
			НапильникиБылиПроинициализированы = Истина;
			ФабрикаЖелудей.ПроинициализироватьНапильники(ЭтотОбъект);
		КонецЕсли;
	КонецЕсли;

	Если ОпределениеЖелудя = Неопределено Тогда
		ВызватьИсключение СтрШаблон("Не удалось получить определение Желудя по имени Желудя %1", Имя);
	КонецЕсли;

	Если ОпределениеЖелудя.Характер() = ХарактерыЖелудей.Компанейский() Тогда
		Желудь = ИнициализироватьКомпанейскийЖелудь(ОпределениеЖелудя.Имя(), ПрилепляемыеЧастицы);
	ИначеЕсли ОпределениеЖелудя.Характер() = ХарактерыЖелудей.Одиночка() Тогда
		Желудь = ИнициализироватьЖелудьОдиночку(ОпределениеЖелудя.Имя(), ПрилепляемыеЧастицы);
	Иначе
		ВызватьИсключение "Неизвестный характер желудя " + ОпределениеЖелудя.Характер();
	КонецЕсли;

	Возврат Желудь;

КонецФункции

Функция НайтиЖелуди(Имя) Экспорт

	ПроверитьСостояниеВыполнение();

	Результат = Новый Массив();

	Если ВРег(Имя) = ВРег("Поделка") Тогда
		Результат.Добавить(ЭтотОбъект);
		Возврат Новый ФиксированныйМассив(Результат);
	КонецЕсли;

	ОпределенияЖелудей = ФабрикаЖелудей.ПолучитьСписокОпределенийЖелудей(Имя);

	Для Каждого ОпределениеЖелудя Из ОпределенияЖелудей Цикл
		Желудь = НайтиЖелудь(ОпределениеЖелудя.Имя());

		Результат.Добавить(Желудь);
	КонецЦикла;

	Возврат Новый ФиксированныйМассив(Результат);
КонецФункции

Функция НайтиДетальку(ИмяДетальки, ЗначениеПоУмолчанию = Неопределено) Экспорт
	Возврат МенеджерПараметров.Параметр(ИмяДетальки, ЗначениеПоУмолчанию);
КонецФункции

Функция ДобавитьЖелудь(Тип, Имя = "") Экспорт
	ПроверитьСостояниеИнициализация();
	ФабрикаЖелудей.ДобавитьЖелудь(Тип, Имя);

	Возврат ЭтотОбъект;
КонецФункции

Функция ДобавитьДуб(Тип) Экспорт
	ПроверитьСостояниеИнициализация();
	ФабрикаЖелудей.ДобавитьДуб(Тип);

	Возврат ЭтотОбъект;
КонецФункции

Функция ДобавитьНапильник(Тип) Экспорт
	ПроверитьСостояниеИнициализация();
	ФабрикаЖелудей.ДобавитьНапильник(Тип);

	Возврат ЭтотОбъект;
КонецФункции

Функция ДобавитьЗаготовку(Тип) Экспорт
	
	ПроверитьСостояниеИнициализация();

	ОпределениеЗаготовки = ФабрикаЖелудей.ДобавитьЗаготовку(Тип);

	Заготовка = НайтиЖелудь(ОпределениеЗаготовки.Имя());
	Заготовка.ПриИнициализацииПоделки(ЭтотОбъект);

	Возврат ЭтотОбъект;

КонецФункции

Функция ДобавитьРогатку(Тип) Экспорт
	
	ПроверитьСостояниеИнициализация();

	ОпределениеЗаготовки = ФабрикаЖелудей.ДобавитьРогатку(Тип);
	ИмяЗаготовки = ОпределениеЗаготовки.Имя();

	Рогатки.Добавить(ИмяЗаготовки);

	Возврат ЭтотОбъект;

КонецФункции

Функция ПросканироватьКаталог(Каталог) Экспорт

	Файлы = НайтиФайлы(Каталог, "*.os", Истина);
	Для Каждого Файл Из Файлы Цикл
		ТипЖелудя = Неопределено;
		Попытка
			ТипЖелудя = Тип(Файл.ИмяБезРасширения);
		Исключение
			Продолжить;
		КонецПопытки;

		РефлекторОбъекта = Новый РефлекторОбъекта(ТипЖелудя);
		Если РефлекторОбъекта.ПолучитьТаблицуМетодов("Желудь", Ложь).Количество() > 0 Тогда
			ДобавитьЖелудь(ТипЖелудя);
		ИначеЕсли РефлекторОбъекта.ПолучитьТаблицуМетодов("Дуб", Ложь).Количество() > 0 Тогда
			ДобавитьДуб(ТипЖелудя);
		ИначеЕсли РефлекторОбъекта.ПолучитьТаблицуМетодов("Напильник", Ложь).Количество() > 0 Тогда
			ДобавитьНапильник(ТипЖелудя);
		ИначеЕсли РефлекторОбъекта.ПолучитьТаблицуМетодов("Рогатка", Ложь).Количество() > 0 Тогда
			ДобавитьРогатку(ТипЖелудя);
		ИначеЕсли РефлекторОбъекта.ПолучитьТаблицуМетодов("Заготовка", Ложь).Количество() > 0 Тогда
			ДобавитьЗаготовку(ТипЖелудя);
		Иначе // BSLLS:EmptyCodeBlock-off
			// no-op
		КонецЕсли;
	КонецЦикла;
	
	Возврат ЭтотОбъект;

КонецФункции

Процедура ЗапуститьПриложение() Экспорт

	ПроверитьСостояниеИнициализация();

	СостояниеПриложения = СостоянияПриложения.Выполнение();

	Для Каждого ИмяРогатки Из Рогатки Цикл
		Рогатка = НайтиЖелудь(ИмяРогатки);
		Рогатка.ПриЗапускеПриложения();
	КонецЦикла;

КонецПроцедуры

Функция ИнициализироватьКомпанейскийЖелудь(Имя, ПрилепляемыеЧастицы)

	Желудь = Неопределено;

	Попытка
		Желудь = ФабрикаЖелудей.НайтиЖелудь(ЭтотОбъект, Имя, ПрилепляемыеЧастицы);
	Исключение
		Лог.Ошибка("Не удалось инициализировать желудь %1", Имя);
		Лог.Ошибка(ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
	КонецПопытки;

	Возврат Желудь;

КонецФункции

Функция ИнициализироватьЖелудьОдиночку(Имя, ПрилепляемыеЧастицы)

	Желудь = ИнициализированныеЖелудиОдиночки.Получить(Имя);

	// double-lock checking
	Если Желудь = Неопределено Тогда
		Попытка
			Семафор = Семафоры.Получить(Имя);
			Семафор.Захватить();
			
			Желудь = ИнициализированныеЖелудиОдиночки.Получить(Имя);
			Если Желудь = Неопределено Тогда
				Желудь = ФабрикаЖелудей.НайтиЖелудь(ЭтотОбъект, Имя, ПрилепляемыеЧастицы);
				ИнициализированныеЖелудиОдиночки.Вставить(Имя, Желудь);
			КонецЕсли;
			
			Семафор.Освободить();
		Исключение
			Лог.Ошибка("Не удалось инициализировать желудь %1", Имя);
			Лог.Ошибка(ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			Семафор.Освободить();
		КонецПопытки;
	КонецЕсли;

	Возврат Желудь;

КонецФункции

Процедура ПроверитьСостояниеИнициализация()

	Если не СостояниеПриложения = СостоянияПриложения.Инициализация() Тогда
		ВызватьИсключение "Приложение не находится в состоянии инициализации. Операция запрещена.";
	КонецЕсли;

КонецПроцедуры

Процедура ПроверитьСостояниеВыполнение()

	Если не СостояниеПриложения = СостоянияПриложения.Выполнение() Тогда
		ВызватьИсключение "Приложение не находится в состоянии выполнения. Операция запрещена.";
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриСозданииОбъекта()
	ИнициализированныеЖелудиОдиночки = Новый Соответствие();
	Рогатки = Новый Массив();
	ФабрикаЖелудей = Новый ФабрикаЖелудей();
	СостояниеПриложения = СостоянияПриложения.Инициализация();
	НапильникиБылиПроинициализированы = Ложь;

	ФабрикаЖелудей.ДобавитьСистемныйНапильник(Тип("ОбработкаНапильникомПластилинаНаПолях"));
	ФабрикаЖелудей.ДобавитьСистемныйНапильник(Тип("ОбработкаНапильникомФинальныйШтрих"));

	Лог = Логирование.ПолучитьЛог("oscript.lib.autumn.application.context");

	МенеджерПараметров = Новый МенеджерПараметров();
	// TODO: Добавить провайдеры для переменных среды и аргументов командной строки
	МенеджерПараметров.ИспользоватьПровайдерJSON();
	МенеджерПараметров.ИспользоватьПровайдерYAML();

	НастройкаФайловогоПровайдера = МенеджерПараметров.НастройкаПоискаФайла();
	
	НастройкаФайловогоПровайдера.УстановитьСтандартныеКаталогиПоиска("src");

	НастройкаФайловогоПровайдера.УстановитьИмяФайла("autumn-properties");

	МенеджерПараметров.Прочитать();

	Заготовки = Осень.ПолучитьЗаготовкиДляАвтоИнициализации();

	Для Каждого ИмяТипаЗаготовки Из Заготовки Цикл
		ДобавитьЗаготовку(Тип(ИмяТипаЗаготовки));
	КонецЦикла;

	Заготовки.Очистить();

КонецПроцедуры
