crsp = readtable('crsp20042008.csv');
crsp = crsp(1:600, :);
crsp.datenum = datenum(num2str(crsp.DateOfObservation), 'yyyymmdd');
crsp = sortrows(crsp, {'PERMNO', 'datenum'});

%variableList = {'PERMNO', 'marketCap', 'adjustedPrice'};
variableList = {'marketCap', 'adjustedPrice'};


k = 5;

crsp = addLags(variableList, k, crsp);

function crsp=addLags(variableList,k,crsp)
   w = width(crsp)
   l = length(variableList);

   vLOut = strcat(...
       'lag'...
       ,num2str(k)...
       ,variableList);
   lagPermno = [NaN(k, 1); crsp.PERMNO(1:end-k)];


   crsp{:, vLOut } = crsp{:, variableList};

   crsp{k+1:end, vLOut } = crsp{1:end-k, vLOut};

   isSameFirm = (crsp.PERMNO ~= lagPermno);
   crsp{isSameFirm, w+1:w+l} = NaN;
end
