 //Рычков Александр Александрович
 // Паскаль АБС.НЕТ
 {28. Задано  некоторое  слово.  Требуется  составить из букв
этого  слова  максимальное  количество  других  слов,  которые 
имеются  в  словаре.  Каждая  буква  заданного   слова   может 
использоваться  только  один  раз.  Например,  если в заданном
слове  имеется 2 буквы 'а', то слова словаря, в которых больше
двух  букв 'а', не подходят. Каждое найденное слово из словаря
оценивается  количеством очков, равным  длине слова. Результат
игры определяется суммой  очков. Первая  строка входного файла
содержит  заданное  слово. Далее  находятся слова словаря. Все 
слова  состоят   из   строчных  (маленьких)  латинских   букв. 
Количество слов словаря  не  превышает 100. В каждом  слове не 
более 20  букв. Длина  заданного  слова  также  не  больше  20 
символов. В первой строке выводится количество набранных очков. 
Начиная со второй строки, следуют найденные слова. Они  должны
выводиться  по  одному  в  строке по убыванию количества букв. 
Слова  с  одинаковым  количеством  букв  должны  следовать  по 
алфавиту (9).
Пример
Ввод         Вывод
bariton      29
tara         brant
triton       tiran
roba         brat
tonna        brit
brat         nota
nota         roba
tiran        rab
brant
bob
rab
brit}

const
  MaxWords = 100;
  MaxWordLength = 20;
type
 Word = array[1..MaxWords] of string;
var
  input,output: text;
  inputFile, outputFile: string;
  CountWord, i, Score: integer;
  Letter, temp: string;
  Let: Word;
  dictionary: Word;
  bol: boolean;
 //Процедура для сортировки слов по убыванию длинны и алфавиту
 procedure SortWord(Let: Word; CountWord: integer);
 var
   i,j,k: integer;
   temp, tempLetOne, tempLetTwo: string;
 begin
    for i:= 1 to CountWord -1 do
    begin
      for j:= i+1 to CountWord do
      begin
        if length(Let[i]) < length(Let[j])
        then
          begin
            temp:= Let[i];
            Let[i]:= Let[j];
            Let[j]:= temp
          end
        else
        if length(Let[i]) = length(Let[j])
        then
          begin
            tempLetOne:= Let[i];
            tempLetTwo:= Let[j];
            for k:= 1 to length(tempLetOne)
            do
              begin
                if tempLetOne[k] > tempLetTwo[k]
            then
              begin
                temp:= Let[i];
                Let[i]:= Let[j];
                Let[j]:= temp;
                break;
              end
            else 
              if tempLetOne[k] < tempLetTwo[k] 
              then
                break;
              end;
          end;    
      end;
    end;
    for i:= 1 to CountWord do
    begin
      writeln(output, Let[i])
    end;
 end;
//функция проверяет входит ли это слово в основное
function CanFormWord(Letter: string; temp: string): boolean;
var
  i,j: integer;
  flagOne, flagTwo: string;
  bol: boolean;
  begin
    bol := TRUE;
    flagOne:= Letter;
    flagTwo:= temp;
    for i:= 1 to length(flagOne) do
    begin
      for j:= 1 to length(flagTwo) do
      begin
        if flagOne[i] = flagTwo[j]
        then
          begin
            flagOne[i]:= '.';
            flagTwo[j]:= '.';
          end  
      end
    end;
    for j:= 1 to length(flagTwo) do
    begin
      if flagTwo[j] <> '.'
      then
        begin
          bol := FALSE;
          break
        end;
        
    end;
  CanFormWord := bol;
  end;
 
 //Основная программа
  begin
    writeln('Введите входной файл');
    readln(inputFile);
    assign(input, inputFile);
    reset(input);
    readln(input,Letter);
    CountWord:= 1;
    Score:= 0;
    while (not eof(input)) and (CountWord < MaxWords) do
    begin
      readln(input,temp);
      if CanFormWord(Letter, temp) = TRUE
      then
        begin
          dictionary[CountWord]:= temp;
          CountWord:= CountWord + 1;
          Score:= Score + length(temp)
        end;
    end; 
    close(input);
    writeln('Введите выходной файл');
    read(outputFile);
    assign(output, outputFile);
    rewrite(output);
    writeln(output, Score);
    SortWord(dictionary, CountWord);
    close(output);
  end.