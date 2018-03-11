%Evolutionary Optimization 1.0
tic
D = [1,1,1,1,1,1;
     1,0,1,1,0,1;
     0,0,0,0,0,1;
     1,0,1,0,1,0;
     0,1,1,0,0,0;
     1,0,0,1,1,0];
 n=6
%Collect information about data
[numRows, numCols] = size(D);
perm = [1:numRows];
%maxK = numRows*(numRows - 1)/2
maxP = factorial(numRows);
n=6;
%First: Generate a population (i.e. generate rankings)
%NOTE: There are numRows! possible rankings
%FIX: Start with a more diverse firstGen

%Write a for loop using randperm for get a more random initial population
firstGen = [];
for i = 1:numRows*10
    perm = nextperm(perm, numRows);
    firstGen = [firstGen perm'];
end
firstGen;

%Second: Calculate fitness
%As of now, fitness = k
%Need to find a way to keep track of permuatations and their fitness
firstGenFit = [];
%op=[]
 for i = 1:length(firstGen)
    % perm=nextperm(perm,i);
     perm = firstGen(:,i);
     A = D(perm, perm);
     fitness=nnz(tril(A))+(numRows*(numRows-1)/2 - nnz(triu(A,1)));
     firstGenFit = [firstGenFit; fitness];
     %op = [op; i, fitness]
 end
%B = [sortrows(op, 2)]

%Third: Selection
%Probability of choosing a member is proportional to its rank

distinctMeme = [];
postnMult = [];

firstGenFit
distinctMeme = unique(firstGenFit)
counts = histcounts(firstGenFit(:),distinctMeme)
%firstGen = [firstGen perm'];

%G=[]
totper = 0
maxk = max(distinctMeme)

for i = 1:length(distinctMeme);
    maxovk = maxk/(distinctMeme(i,1));
    totper = totper + maxovk;
%     pmax = 1/totper
%     pk= pmax * maxovk
%     D=[D; i,pk]
end



pmax = 1/totper
pk=[]
for i = 1:length(distinctMeme);
    maxovk = maxk/(distinctMeme(i,1));
    pmulk= pmax * maxovk ; %pmulk total probability for all permutations with fitness  k
    pk = [pk repelem(pmulk/ counts(i),counts(i))];

%     for i=1:counts(i)
%
%         D=[D; j,distinctMeme(i),pk]
%         j= j+1;
%     end
end
T = [[1:60]', firstGenFit]
U = sortrows(T,2)
V = [U , pk']
%min(minfirstGenFit);

%Third: Selection
%Probability of choosing a member is proportional to its rank







%Four: Mating
%Choose members of population at random to cross
newk=20%min(firstGenFit);
while newk >= 20%min(firstGenFit)
    while mate1==mate2
P = pk
X = U(:,1)'
%%%
Q = cumsum(P);
m1 = X(1+sum(Q(end)*rand>Q));
m2=X(1+sum(Q(end)*rand>Q));
mate1=firstGen(:,m1)
mate2=firstGen(:,m2)
    end
    B=[]
    C=[]
    F=[]
    offSpring= []
for i=1:n
    if mate1(i,1)==mate2(i,1)
        offSpring(i,1)=mate1(i,1)
        B=[B,i]
    end
    if mate1(i)~=mate2(i)
        j=find(mate2==mate1(i))
        C= [C; mate1(i),i+j]
    end
    %         sortrows(C,2)
    %         for i=(1:n)-B
    %             offSpring(i)=D(i,1)
    %         end Need to make accessible
end
F=sortrows(C,2)
E=setdiff([1:n],B)
j=0
     for i=E
            offSpring(i,1)=F(j+1,1);
            j=j+1;
     end
 R = D(offSpring,offSpring);
newk =nnz(tril(R))+(numRows*(numRows-1)/2 - nnz(triu(R,1)));
end
    offSpring
    mate1
    mate2
    newk
toc
