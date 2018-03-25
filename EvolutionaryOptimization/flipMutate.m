function y = flipMutate(member)
  dim = length(member);
  newMember = zeros(dim,1);
  j = 1;
  for i = length(member):-1:1
    newMember(j) = member(i);
    j = j+1;
  end

  y = newMember;
end
