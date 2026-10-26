&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Попытка
		Сообщить("OpenCode 1C smoke test: FORM_OPENED");
		Запись = Новый ЗаписьТекста("C:\Users\Home\Documents\Default Project\build\logs\runtime-marker.txt", КодировкаТекста.UTF8);
		Запись.ЗаписатьСтроку("OpenCode 1C smoke test: PASS " + ТекущаяДатаСеанса());
		Запись.Закрыть();
	Исключение
		Попытка
			Запись = Новый ЗаписьТекста("C:\Users\Home\Documents\Default Project\build\logs\runtime-error.txt", КодировкаТекста.UTF8);
			Запись.ЗаписатьСтроку("ERROR " + ОписаниеОшибки());
			Запись.Закрыть();
		Исключение
			// Сбой записи файла ошибки не влияет на результат smoke-теста.
		КонецПопытки;
	КонецПопытки;
КонецПроцедуры
