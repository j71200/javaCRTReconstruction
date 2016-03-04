function res_str = dispthese_debug(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)

res_str = [];
if ischar(a1)
	res_str = [res_str ' ' a1];
else
	res_str = [res_str ' ' num2str(a1)];
end

if exist('a2', 'var')
	if ischar(a2)
		res_str = [res_str ' ' a2];
	else
		res_str = [res_str ' ' num2str(a2)];
	end
end
if exist('a3', 'var')
	if ischar(a3)
		res_str = [res_str ' ' a3];
	else
		res_str = [res_str ' ' num2str(a3)];
	end
end
if exist('a4', 'var')
	if ischar(a4)
		res_str = [res_str ' ' a4];
	else
		res_str = [res_str ' ' num2str(a4)];
	end
end
if exist('a5', 'var')
	if ischar(a5)
		res_str = [res_str ' ' a5];
	else
		res_str = [res_str ' ' num2str(a5)];
	end
end
if exist('a6', 'var')
	if ischar(a6)
		res_str = [res_str ' ' a6];
	else
		res_str = [res_str ' ' num2str(a6)];
	end
end
if exist('a7', 'var')
	if ischar(a7)
		res_str = [res_str ' ' a7];
	else
		res_str = [res_str ' ' num2str(a7)];
	end
end
if exist('a8', 'var')
	if ischar(a8)
		res_str = [res_str ' ' a8];
	else
		res_str = [res_str ' ' num2str(a8)];
	end
end
if exist('a9', 'var')
	if ischar(a9)
		res_str = [res_str ' ' a9];
	else
		res_str = [res_str ' ' num2str(a9)];
	end
end
if exist('a10', 'var')
	if ischar(a10)
		res_str = [res_str ' ' a10];
	else
		res_str = [res_str ' ' num2str(a10)];
	end
end

disp(res_str);

end
