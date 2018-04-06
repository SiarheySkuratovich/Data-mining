fid = fopen('data12.txt','r');
X = fscanf(fid, '%g %g', [2 inf]);
fclose(fid);
X = X';
gscatter(X(:,1),X(:,2));
size = length(X);
hold on;


k = 4; % количество центров кластеров
C = zeros(k,2); % задание начальных центров кластеров
for i = 1 : k
    C(i, :) = X(i , :);
end

U = zeros(size,2);
exit = false;
Q = 999;
e = 0.0001;
m = 1;


while exit == false
%считаем расстояния от обектов до предполагаемых центров кластеров
  for i = 1:size
    d = zeros(k,1);
    for j= 1:k
      %вектор расстояний объекта до всех кластеров
      d(j) = pdist([C(j,:); X(i,:)],'minkowski', 4);
      d;
    end
    %берём минимальное значение расстояния и с соотв индексом
    %заполнякм матрицу с индексами кластеров и расстоянием до их центра
    [U(i,2), U(i,1)] = min(d);
  end
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  klaster_1 = zeros(0, 2);
  klaster_2 = zeros(0, 2);
  klaster_3 = zeros(0, 2);
  klaster_4 = zeros(0, 2);
  

  for i =  1:size
      if U(i,1) == 1
        klaster_1 = [klaster_1; X(i,:)];
      end
       if U(i,1) == 2
        klaster_2 = [klaster_2; X(i,:)];
       end
      if U(i,1) == 3
        klaster_3 = [klaster_3; X(i,:)];
      end
      if U(i,1) == 4
        klaster_4 = [klaster_4; X(i,:)];
      end  
  end
  
  
  distBeetweenObjs_1 = pdist(klaster_1,'minkowski', 4);
  distBeetweenObjs_2 = pdist(klaster_2,'minkowski', 4);
  distBeetweenObjs_3 = pdist(klaster_3,'minkowski', 4);
  distBeetweenObjs_4 = pdist(klaster_4,'minkowski', 4);

 

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
  Qn = sum(distBeetweenObjs_1) + sum(distBeetweenObjs_2) + sum(distBeetweenObjs_3) + sum(distBeetweenObjs_4);
  abs(Q-Qn);
  if abs(Q-Qn) < e
     exit = true;
     continue
  end
  Q = Qn;

  C = zeros(k,2);
  for i = 1:size
    C(U(i,1),:) = C(U(i,1),:) + X(i,:);
  end
  C = C/(size/k);  
end
hold on
scatter(C(:,1),C(:,2))
