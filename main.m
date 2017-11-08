crsp = readtable('crsp20042008.csv');
crsp = crsp(1:600, :);
crsp.datenum = datenum(num2str(crsp.DateOfObservation), 'yyyymmdd');
crsp = sortrows(crsp, {'PERMNO', 'datenum'});

variableList = {'PERMNO', 'marketCap', 'adjustedPrice'};


k = 2;

crsp = addLags(variableList, k, crsp);

% crsp.col = [ NaN(k, 1); crsp.marketCap(1:end-k) ]
% crsp.col2 = [NaN(k, 1); crsp.adjustedPrice(1:end - k) ]
% crsp.PERM2 = [ NaN(k, 1); crsp.PERMNO(1:end - k) ]
% crsp.col (crsp.PERMNO ~= crsp.PERM2) = NaN;


function crsp=addLags(variableList,k,crsp)
   w = width(crsp)
   l = length(variableList);

   vLOut = strcat(...
       'lag'...
       ,num2str(k)...
       ,variableList);


   crsp{:, vLOut } = crsp{:, variableList};

   crsp{k+1:end, vLOut } = crsp{1:end-k, vLOut};

   temp = (crsp.PERMNO ~= crsp{:, w+1});
   %crsp(temp, w+1:w+k) = NaN;
   crsp{temp, w+1:w+l} = NaN
   %(crsp.PERMNO ~= crsp(:,w+1)) = NaN;
   %crsp.PERMNO ~= "crsp.lag3PERMNO"
end
