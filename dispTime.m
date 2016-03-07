function currentTime_str = dispTime(isShow)

currentTime = clock;
YYYY = currentTime(1);
MM = currentTime(2);
DD = currentTime(3);
hh = currentTime(4);
mm = currentTime(5);
ss = floor(currentTime(6));

YYYY_str = num2str(YYYY);
if MM < 10
	MM_str = ['0' num2str(MM)];
else
	MM_str = num2str(MM);
end
if DD < 10
	DD_str = ['0' num2str(DD)];
else
	DD_str = num2str(DD);
end
if hh < 10
	hh_str = ['0' num2str(hh)];
else
	hh_str = num2str(hh);
end
if mm < 10
	mm_str = ['0' num2str(mm)];
else
	mm_str = num2str(mm);
end
if ss < 10
	ss_str = ['0' num2str(ss)];
else
	ss_str = num2str(ss);
end

currentTime_str = [YYYY_str '/' MM_str '/' DD_str '  ' hh_str ':' mm_str ':' ss_str];

if ~exist('isShow', 'var')
	isShow = true;
end
if isShow
	disp(currentTime_str);
end

end