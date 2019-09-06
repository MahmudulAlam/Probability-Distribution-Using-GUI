function return_value = user_input(x,mat,col)
% Making the dialog box
return_value = [] ;
d = dialog('Position',[400 350 300 150],'Name','Calculate Probability',...
           'WindowStyle','normal');
txt1 = uicontrol('Parent',d,'Style','text','Position',...
            [50 100 210 40],'String','Find Probability') ;
set(txt1, 'FontSize',12,'FontWeight','Bold');
d.CreateFcn = @movegui ;
%hgsave(d,'onscreenfig') ;
% Making the popup box
if col == 1 
    dataName = 'Univariate Data' ; 
elseif col == 2 
    dataName = 'Bivariate Data' ; 
else 
    dataName = 'No file selected' ; 
end
txt2 = uicontrol('Parent',d,'Style','text','Position',[40 75 220 25],...
                  'String',dataName,'FontName','courier new');
set(txt2, 'FontSize',16,'FontWeight','Bold');
% Making the button
button_start = uicontrol('Style','Pushbutton','Parent',d,'Position',...
                         [110 25 80 30],'String','Start','Callback',@popup_callback);
set(button_start,'FontSize',12,'FontWeight','Bold');
set(button_start, 'backgroundcolor',[.5294 .8667 .9412]);
% Wait for d to close before running to completion
uiwait(d) ;
function popup_callback(popup,event)
    idx = popup.Value;
    popup_items = popup.String;
    popup_str = char(popup_items(idx,:));
    if strcmp(dataName,'Univariate Data')
        prompt=({'Lower Limit','Upper Limit'}) ;
        name = 'Limits of Integration' ; 
        mu = mean(x) ;
        v = variance(x) ;
        sd = sqrt(v) ;
        % Transforming to the standard form
        a1 = mu + (-1) * sd ;
        a2 = mu + 1 * sd ; 
        % Setting default values
        defaultans = {num2str(a1),num2str(a2)};
        options.WindowStyle = 'normal';
        answer = inputdlg(prompt,name,[1 45],defaultans,options);
        if isempty(answer) == 1
            return ;
        end
        answer = char(answer) ;
        answer = str2num(answer) ;
        p = trapezoidal1(x,answer(1),answer(2)) ;
        p = round(p*100*10^2)./ 10^2 ; % keeps only 2 digit
        string = ['Probability is : ' num2str(p) '%'] ;
        h = msgbox(string,':)');
        set(h, 'position', [300 300 150 60]);
        set(h,'WindowStyle','normal') ;
        ah = get(h,'CurrentAxes' );
        ch = get(ah,'Children' );
        set( ch, 'FontSize', 12,'Fontweight','Bold');
        return_value = p ; 
    elseif strcmp(dataName,'Bivariate Data')
        prompt=({'Lower Limit of x','Upper Limit of x',...
                 'Lower Limit of y','Upper Limit of y'}) ;
        name =   'Limits of Integration' ;
        % Setting default values
        defaultans = {'45','55','44','55'};
        options.WindowStyle = 'normal';
        answer = inputdlg(prompt,name,[1 50],defaultans,options);
        if isempty(answer) == 1
            return ;
        end
        answer = char(answer) ;
        answer = str2num(answer) ;
        p = trapezoidal2(mat,answer(1),answer(2),answer(3),answer(4)) ;
        p = round(p*100*10^2)./ 10^2 ; % keeps only 2 digit
        string = ['Total Probability is : ' num2str(p) '%'] ;
        h = msgbox(string,':)');
        set(h, 'position', [300 300 170 60]);
        set(h,'WindowStyle','normal') ;
        ah = get(h,'CurrentAxes' );
        ch = get(ah,'Children' );
        set( ch, 'FontSize', 12,'Fontweight','Bold');
        return_value = p ;
    else
        m = msgbox('  Please, select a file',':(') ; 
        set(m,'Position',[400 350 135 50]) ; 
        ah = get( m, 'CurrentAxes' );
        ch = get( ah, 'Children' );
        set(ch, 'Fontsize',12,'FontWeight','Bold') ; 
        return_value = [] ;
    end
  end
end

