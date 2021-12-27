function [SSD] = SSD(a,b)

differences = a - b;
SSD = sum(differences(:).^2);
end