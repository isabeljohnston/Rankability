function y = katelynnMethod(mate1, mate2)

   n = length(mate1)
   B = [];
   C = [];
   F = [];
  for i=1:n
      if mate1(i,1)==mate2(i,1)
          offspring(i,1)=mate1(i,1);
          B=[B,i];
      end
      if mate1(i)~=mate2(i)
          j=find(mate2==mate1(i));
          C=[C; mate1(i),i+j];
      end

  end
  F=sortrows(C,2);
  E=setdiff([1:n],B);
  j=0;

  for i=E
        offspring(i,1)=F(j+1,1);
        j=j+1;
  end

y = offspring;
end
