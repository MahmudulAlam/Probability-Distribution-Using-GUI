function ProbDistGUI
% Md Mahmudul Alam
% github.com/MahmudulAlam
clc , clf , clear , close all ;
x = [] ; 
r = [] ; 
col = 0 ;
% Getting the pixel of screen
pixel = get(0,'screensize') ;
% Creating a figure and axes
fig = figure('Name','Probability Distribution Using Graphical User Interface',...
             'NumberTitle','off','Visible','off','position',pixel);
% Creating push buttons
btn0 = uicontrol('Style','pushbutton','String','Load File',...
                 'Position',[30 600 80 35],'Callback',@load_file); 
set(btn0,'FontSize',13,'FontWeight','Bold');
set(btn0,'backgroundcolor',[1 .2 0]); 

btn1 = uicontrol('Style','pushbutton','String','Plot',...
                 'Position',[30 500 80 35],'Callback',@setplot); 
set(btn1,'FontSize',12,'FontWeight','Bold');
set(btn1,'backgroundcolor',[.4 1 .4]); 

btn2 = uicontrol('Style','pushbutton','String','Hist',...
                 'Position',[30 450 80 35],'Callback',@sethist); 
set(btn2,'FontSize',12,'FontWeight','Bold');
set(btn2,'backgroundcolor',[1 .4 0]);

btn3 = uicontrol('Style','pushbutton','String','Surf',...
                 'Position',[30 400 80 35],'Callback',@setsurf); 
set(btn3,'FontSize',12,'FontWeight','Bold');
set(btn3,'backgroundcolor',[.8 .2 1]); 

btn4 = uicontrol('Style','pushbutton','String','Contourf',...
                 'Position',[30 350 80 35],'Callback',@setcontourf); 
set(btn4,'FontSize',12,'FontWeight','Bold');
set(btn4,'backgroundcolor','c');

btn_C = uicontrol('Style', 'pushbutton', 'String', 'Probability',...
      'Position', [30 130 100 35],'Callback',@calprob);       
set(btn_C,'FontSize',12,'FontWeight','Bold') ;
set(btn_C,'backgroundcolor',[.2 .6 1]);
% Creating pop-up menu
popup = uicontrol('Style', 'popup',...
       'String', {'Parula','Jet','HSV','Hot','Cool','Spring',...
       'Summer','Autumn','Winter','Gray','Bone','Copper',...
       'Pink','Lines'},'Position', [30 275 100 50],...
       'Callback', @setmap);    
set(popup,'FontSize',12,'backgroundcolor',[.73 .83 .96]);

% Make figure visble after adding all components
set(fig,'Visible','on') ;

% All Callback Funcitons
function load_file(source,event)
    [filename, path] = uigetfile('.xls','Select the data file') ; 
    if filename ~= 0
        data = xlsread(strcat(path, filename)) ;
        [row, col] = size(data) ; 
    end 
    if col == 1
        x = data ; % Univariate data 
    elseif col == 2
        r = data ; % Bivariate data 
    end
end
function setplot(source,event)
    if col == 1 
        [count,center] = hist(x,15) ;
        new_x = round(min(x)) : .1 :round(max(x)) ;
        prob = probability(x,new_x) ;
        % Plotting normalized histogram
        bw = center(2) - center(1) ;
        bar(center,count/bw/sum(count),'FaceColor',[.3,.75,.93]) ;
        hold on ; 
        plot(new_x,prob,'LineWidth',2,'color',[.49,.18,.56]) ;
        hold off ;
        title( 'Probability Density Function','LineWidth',2,...
               'FontSize',14,'FontWeight','Bold') ;
        xlabel('X Value','LineWidth',2,'FontSize',12,...
               'FontWeight','Bold') ;
        ylabel('Probability Density','LineWidth',2,'FontSize',12,...
               'FontWeight','Bold') ;
        grid on ; 
    end
    if col == 2
        x3 = r(:,1) ;
        y3 = r(:,2) ;
        plot(x3,y3,'O','LineWidth',2,'MarkerFaceColor','c',...
               'MarkerEdgeColor',[.49 .18 .56]) ;
        title( 'Randomly Distributed Points','LineWidth',2,...
               'FontSize',14,'FontWeight','Bold') ;
        xlabel('X Value','LineWidth',2,'FontSize',12,...
               'FontWeight','Bold') ;
        ylabel('Y Value','LineWidth',2,'FontSize',12,...
               'FontWeight','Bold') ;
        grid on ;
    end
end
function sethist(source,event)
    if col == 1 
        hist(x,15) ;
        title( 'Histogram of the Distributed Points',...
               'LineWidth',2,'FontSize',14,'FontWeight','Bold') ;
        xlabel('X Value','LineWidth',2,'FontSize',12,...
               'FontWeight','Bold') ;
        ylabel('Frequency','LineWidth',2,'FontSize',12,...
               'FontWeight','Bold') ;
        grid on ;
    end
    if col == 2
        hist3(r,[15,15]) ;
        title( 'Histogram of the Distributed Points',...
               'LineWidth',2,'FontSize',14,'FontWeight','Bold') ;
        xlabel('X Value','LineWidth',2,'FontSize',12,...
               'FontWeight','Bold') ;
        ylabel('Y Value','LineWidth',2,'FontSize',12,...
               'FontWeight','Bold') ;
        zlabel('Frequency','LineWidth',2,'FontSize',12,...
               'FontWeight','Bold') ;
        set(get(gca,'child'),'FaceColor','interp','CDataMode','auto') ;
    end
end
function setsurf(source,event)
    if col == 2
        x1 = r(:,1) ;
        y = r(:,2) ;
        mu = [mean(x1) mean(y)] ;
        co = cov(r) ;
        mu = mu' ;
        new_x = round(min(x1)): .5 :round(max(x1));
        y = round(min(y)): .5 :round(max(y)); 
        [new_x,y] = meshgrid(new_x,y) ;
        v = [new_x(:) y(:)] ; 
        v = v' ; 
        n = length(v) ;
        prob = zeros(1,n) ;
        for i = 1 : n
            prob(i) = exp(-.5 * (v(:,i)-mu)' * pinv(co) * (v(:,i)-mu)) ;
        end
        k = 2 ;
        factor = 1/(sqrt(((2*pi).^k)*det(co))) ;
        prob = prob .* factor ; 
        prob = reshape(prob,size(new_x)) ;
        surf(new_x,y,prob) ;
        title( 'Probability Density Function',...
               'LineWidth',2,'FontSize',14,'FontWeight','Bold') ;
        xlabel('X Value','LineWidth',2,'FontSize',12,...
               'FontWeight','Bold') ;
        ylabel('Y Value','LineWidth',2,'FontSize',12,...
               'FontWeight','Bold') ;
        zlabel('Probability Density','LineWidth',2,'FontSize',12,...
               'FontWeight','Bold') ;
        pbaspect([1 1 .4]);
    end
end
function setcontourf(source,event)
    if col == 2
        x1 = r(:,1) ;
        y = r(:,2) ;
        mu = [mean(x1) mean(y)] ;
        co = cov(r) ;
        mu = mu' ;
        new_x = round(min(x1)): .5 :round(max(x1));
        y = round(min(y)): .5 :round(max(y)); 
        [new_x,y] = meshgrid(new_x,y) ;
        v = [new_x(:) y(:)] ; 
        v = v' ; 
        n = length(v) ;
        prob = zeros(1,n) ;
        for i = 1 : n
            prob(i) = exp(-.5 * (v(:,i)-mu)' * pinv(co) * (v(:,i)-mu)) ;
        end
        k = 2 ;
        factor = 1/(sqrt(((2*pi).^k)*det(co))) ;
        prob = prob .* factor ; 
        prob = reshape(prob,size(new_x)) ;
        contourf(prob) ;
        title( 'Probability Density',...
               'LineWidth',2,'FontSize',14,'FontWeight','Bold') ;
        xlabel('X Value','LineWidth',2,'FontSize',12,...
               'FontWeight','Bold') ;
        ylabel('Y Value','LineWidth',2,'FontSize',12,...
               'FontWeight','Bold') ;
    end
end
function setmap(source,event)
    val = get(source,'Value');
    maps = get(source,'String');
    newmap = maps{val};
    colormap(newmap);
end
function dimension_callback(source,event)
    dim = get(source,'Value');
    if dim == 1     % Univariate
        cla , axis([0 1 0 1]) ;
    elseif dim == 2 % Bivariate
        cla , axis([0 1 0 1 0 1]) ;
    end
end 
function calprob(source,event)
    user_input(x,r,col) ;
end
end
