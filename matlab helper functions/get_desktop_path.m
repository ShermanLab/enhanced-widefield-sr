dsktp_path = winqueryreg('HKEY_CURRENT_USER', 'Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders', 'Desktop');
[str_current_path,~,~] = fileparts(which(mfilename));
if strcmp(str_current_path,'')
    str_current_path = dsktp_path;
end