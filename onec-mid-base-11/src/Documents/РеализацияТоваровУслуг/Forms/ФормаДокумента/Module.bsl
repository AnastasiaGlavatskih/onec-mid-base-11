
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

// {{Главатских А.С. Добавление реквизита на форму "Согласованная скидка" и команды "Пересчитать"
  Группа = Элементы.Добавить("ГруппаСкидка", Тип("ГруппаФормы"), Элементы.ГруппаШапкаЛево);
  Группа.Вид = ВидГруппыФормы.ОбычнаяГруппа;
  
  ПолеВвода = Элементы.Добавить("ЭлементСогласованнаяСкидка", Тип("ПолеФормы"), Группа);
  ПолеВвода.Вид = ВидПоляФормы.ПолеВвода;
  ПолеВвода.ПутьКДанным = "Объект.СогласованнаяСкидка"; 
  ПолеВвода.УстановитьДействие("ПриИзменении", "ПриИзмененииСогласованнаяСкидка");
  
  Команда = Команды.Добавить("ПересчитатьТЧ");
  Команда.Действие = "КомандаПересчитатьТаблицуСоСкидкой";
  
  КнопкаФормы = Элементы.Добавить("КнопкаПересчитать", Тип("КнопкаФормы"), Группа);
  КнопкаФормы.ИмяКоманды = "Пересчитать";
  
  // }}
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
    ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриИзменении(Элемент)
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУслуги

&НаКлиенте
Процедура УслугиКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиПриИзменении(Элемент)
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РассчитатьСуммуСтроки(ТекущиеДанные)
	
	ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество;
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуТЧ(ТаблицаФормы)
	// {{Главатских А.С. пересчет табличной части при изменении "Согласованной скидки"
  
  	Для Каждого Строка Из ТаблицаФормы Цикл
    	РассчитатьСуммуСтроки(Строка); 
  	КонецЦикла;
 	
 	//}}
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуДокумента()
	
	Объект.СуммаДокумента = Объект.Товары.Итог("Сумма") + Объект.Услуги.Итог("Сумма");
	
КонецПроцедуры

&НаКлиенте
Асинх Процедура ПриИзмененииСогласованнаяСкидка(Элемент)
	// {{Главатских А.С. изменение поля "Согласованная скидка"
   
  Если Объект.Товары.Количество() = 0 И Объект.Услуги.Количество() = 0 Тогда
    Возврат
  КонецЕсли;
  
  Вопрос = ВопросАсинх("Изменился процент скидки. Пересчитать сумму?", РежимДиалогаВопрос.ДаНет);
  Результат = Ждать Вопрос;
  
  Если Результат = КодВозвратаДиалога.Да Тогда  
    РассчитатьСуммуТЧ(Объект.Товары);
    РассчитатьСуммуТЧ(Объект.Услуги);
  КонецЕсли;
 
 //}} 
КонецПроцедуры

&НаКлиенте
Процедура КомандаПересчитатьТаблицуСоСкидкой()
	// {{Главатских А.С. команды пересчета ТЧ с учетом скидки
    
  	РассчитатьСуммуСтроки(Объект.Товары);
  	РассчитатьСуммуСтроки(Объект.Услуги)
   	
   	//}}
КонецПроцедуры

#Область ПодключаемыеКоманды

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
    ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
    ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
    ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#КонецОбласти
