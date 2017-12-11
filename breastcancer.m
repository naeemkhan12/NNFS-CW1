data=importdata('breast-cancer-wisconsin.data');
data=data(:,2:11); % neglect first column holding id
% replace zeros with mean value of column 6
meanMat = mean(data); % calculate mean of all columns
meanValue = round(meanMat(6)); % taking round of sixth column of meanMat
data(data==0)=meanValue; % replace zeros with mean value

% classification of data into training and testing data
trainData = data(1:350,1:9);
testData = data(351:699,1:9);
trainGoal = data(1:350,10);
testGoal = data(351:699,10);
%{
training = 90 testing=10
trainData = data(1:630,1:9);
testData = data(631:699,1:9);
trainGoal = data(1:630,10);
testGoal = data(631:699,10);

training = 80 testing=20
trainData = data(1:560,1:9);
testData = data(561:699,1:9);
trainGoal = data(1:560,10);
testGoal = data(561:699,10);

training = 70 testing=30
trainData = data(1:490,1:9);
testData = data(491:699,1:9);
trainGoal = data(1:490,10);
testGoal = data(491:699,10);

training = 60 testing=40
trainData = data(1:420,1:9);
testData = data(421:699,1:9);
trainGoal = data(1:420,10);
testGoal = data(421:699,10);

training = 50 testing=50
trainData = data(1:350,1:9);
testData = data(351:699,1:9);
trainGoal = data(1:350,10);
testGoal = data(351:699,10);

training = 40 testing=60
trainData = data(1:280,1:9);
testData = data(281:699,1:9);
trainGoal = data(1:280,10);
testGoal = data(281:699,10);

training = 30 testing=70
trainData = data(1:210,1:9);
testData = data(211:699,1:9);
trainGoal = data(1:210,10);
testGoal = data(211:699,10);

training = 20 testing=80
trainData = data(1:140,1:9);
testData = data(141:699,1:9);
trainGoal = data(1:140,10);
testGoal = data(141:699,10);

training = 10 testing=90
trainData = data(1:70,1:9);
testData = data(71:699,1:9);
trainGoal = data(1:70,10);
testGoal = data(71:699,10);


%}

% Data Distribution test
%{
Data2 = data(:,10);
benignData=(data(1,:));
malignantData=(data(6,:));
for i=1:size(Data2,1)
    if(Data2(i)==2 && i ~=1)
        benignData=[benignData;data(i,:)];
    elseif(Data2(i)==4 && i~=6)
        malignantData=[malignantData;data(i,:)];
    end
end


malignant= 99 benign=1
trainData=[malignantData(1:118,1:9);benignData(1,1:9)];
trainGoal=[malignantData(1:118,10);benignData(1,10)];
testData=[malignantData(121:241,1:9);benignData(230:458,1:9)];
testGoal=[malignantData(121:241,10);benignData(230:458,10)];

malignant= 90 benign=10
trainData=[malignantData(1:108,1:9);benignData(1:23,1:9)];
trainGoal=[malignantData(1:108,10);benignData(1:23,10)];
testData=[malignantData(121:241,1:9);benignData(230:458,1:9)];
testGoal=[malignantData(121:241,10);benignData(230:458,10)];

malignant= 70 benign=30
trainData=[malignantData(1:84,1:9);benignData(1:69,1:9)];
trainGoal=[malignantData(1:84,10);benignData(1:69,10)];
testData=[malignantData(121:241,1:9);benignData(230:458,1:9)];
testGoal=[malignantData(121:241,10);benignData(230:458,10)];

malignant= 50 benign=50
trainData=[malignantData(1:60,1:9);benignData(1:115,1:9)];
trainGoal=[malignantData(1:60,10);benignData(115,10)];
testData=[malignantData(121:241,1:9);benignData(230:458,1:9)];
testGoal=[malignantData(121:241,10);benignData(230:458,10)];

malignant= 30 benign=70
trainData=[malignantData(1:36,1:9);benignData(161,1:9)];
trainGoal=[malignantData(1:36,10);benignData(161,10)];
testData=[malignantData(121:241,1:9);benignData(230:458,1:9)];
testGoal=[malignantData(121:241,10);benignData(230:458,10)];

malignant=10  benign=90
trainData=[malignantData(12,1:9);benignData(207,1:9)];
trainGoal=[malignantData(12,10);benignData(207,10)];
testData=[malignantData(121:241,1:9);benignData(230:458,1:9)];
testGoal=[malignantData(121:241,10);benignData(230:458,10)];

malignant=1  benign=99
trainData=[malignantData(1,1:9);benignData(227,1:9)];
trainGoal=[malignantData(1,10);benignData(227,10)];
testData=[malignantData(121:241,1:9);benignData(230:458,1:9)];
testGoal=[malignantData(121:241,10);benignData(230:458,10)];


%}
net = newff(trainData',trainGoal',1, {'tansig' 'tansig'}, 'trainr', 'learngd', 'mse');
net.trainParam.goal = 0.01;
net.trainParam.epochs = 80;
%view(net);
net = train(net,trainData',trainGoal');
output = net(testData');
error=0;
for i=1:size(output,2) 
    if((output(i)<3 && testGoal(i)==4) || (output(i)>3 && testGoal(i)==2))
       error=error+1;
    end
end
% Percentage accuracy
disp('Errors ')
disp(error)
disp('Percentage Accuracy')
percentageAccuracy=((size(testGoal)-error)/size(testGoal))*100;
disp(percentageAccuracy)
