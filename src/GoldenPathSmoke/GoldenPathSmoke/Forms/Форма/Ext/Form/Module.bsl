&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Попытка
		// BSLLS:UsingHardcodePath-off
		Запись = Новый ЗаписьТекста("C:\Users\Home\Documents\Default Project\build\logs\goldenpath-marker.txt", КодировкаТекста.UTF8);
		// BSLLS:UsingHardcodePath-on
		Запись.ЗаписатьСтроку("GoldenPath smoke: PASS " + ТекущаяДатаСеанса());
		Запись.Закрыть();
	Исключение
		// Сбой записи маркера не влияет на результат открытия формы.
		Сообщить("GoldenPath smoke: ERROR " + ОписаниеОшибки());
	КонецПопытки;
КонецПроцедуры
