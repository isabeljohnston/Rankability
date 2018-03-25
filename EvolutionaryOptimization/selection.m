function [y,z] = selection(firstGenFit,firstGen,sizePopulation)
  distinctMeme = [];
  postnMult = [];

  %firstGenFit
  distinctMeme = unique(firstGenFit)
  counts = histc(firstGenFit(:),distinctMeme)
  %firstGen = [firstGen perm'];

  %G=[]
  totper = 0
  maxk = max(distinctMeme)

  distinctM = distinctMeme
  for k = 1:length(distinctMeme)
      maxovk = maxk/(distinctMeme(k,1));
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
  T = [[1:sizePopulation]', firstGenFit]
  U = sortrows(T,2)
  V = [U , pk']
  %min(minfirstGenFit);

  %Four: Mating
  %Choose members of population at random to cross
  %newFit = max(firstGenFit);
%  x = max(firstGenFit)+1;
  %max(firstGenFit)
%  while newFit>min(firstGenFit)+5;
%      x=newFit;
P = pk;
X = U(:,1)';
%%%
Q = cumsum(P);
m1 = X(1+sum(Q(end)*rand>Q));
m2 = X(1+sum(Q(end)*rand>Q));
while m1==m2
%while mate1==mate2

    m1 = X(1+sum(Q(end)*rand>Q));
    m2 = X(1+sum(Q(end)*rand>Q));
end
y = firstGen(:,m1);
z = firstGen(:,m2);
