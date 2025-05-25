

function Main
fig = figure('Name', 'Numerical Methods Calculator', 'NumberTitle', 'off', ...
    'MenuBar', 'none', 'Resize', 'on', 'Position', [100, 50, 800, 600], ...
    'Color', ...
    [0.95, 0.95, 0.95]);


uicontrol('Style', 'text', 'String', 'Numerical Methods Calculator', ...
    'Position', [10, 570, 300, 20], 'FontSize', 10, 'FontWeight', 'bold', ...
    'BackgroundColor', [0.95, 0.95, 0.95], 'HorizontalAlignment', 'left');


methodPanel = uipanel('Title', 'Method', 'Position', [0.01, 0.85, 0.98, 0.1], ...
    'FontSize', 8, 'BackgroundColor', [0.95, 0.95, 0.95]);

methods = {'Graphical', 'Incremental', 'Bisection', 'Newton-Raphson', 'Regula Falsi', 'Secant'};


methodGroup = uibuttongroup('Parent', methodPanel, 'Position', [0.01, 0.1, 0.98, 0.8], ...
    'BorderType', 'none', 'BackgroundColor', [0.95, 0.95, 0.95]);

methodButtons = zeros(length(methods), 1);
for j = 1:length(methods)
    xPos = (j-1) * 0.16 + 0.01;
    methodButtons(j) = uicontrol('Parent', methodGroup, 'Style', 'radiobutton', ...
        'String', methods{j}, 'Position', [xPos*780, 5, 120, 20], ...
        'FontSize', 8, 'BackgroundColor', [0.95, 0.95, 0.95]);
end


set(methodGroup, 'SelectionChangedFcn', @methodChanged);


inputPanel = uipanel('Title', 'Function', 'Position', [0.01, 0.75, 0.98, 0.09], ...
    'FontSize', 8, 'BackgroundColor', [0.95, 0.95, 0.95]);

uicontrol('Parent', inputPanel, 'Style', 'text', 'String', 'f(x) =', ...
    'Position', [10, 15, 30, 15], 'HorizontalAlignment', 'left', 'FontSize', 8, ...
    'BackgroundColor', [0.95, 0.95, 0.95]);
eqnEdit = uicontrol('Parent', inputPanel, 'Style', 'edit', 'String', '', ...
    'Position', [45, 15, 650, 20], 'HorizontalAlignment', 'left', 'FontSize', 8);


uicontrol('Parent', inputPanel, 'Style', 'pushbutton', 'String', 'Preview', ...
    'Position', [705, 15, 60, 20], 'Callback', @previewFunction, 'FontSize', 8);


paramsPanel = uipanel('Title', 'Parameters', 'Position', [0.01, 0.65, 0.98, 0.09], ...
    'FontSize', 8, 'BackgroundColor', [0.95, 0.95, 0.95]);


incrPanel = uipanel('Parent', paramsPanel, 'Position', [0.01, 0.01, 0.98, 0.98], ...
    'BorderType', 'none', 'BackgroundColor', [0.95, 0.95, 0.95]);

uicontrol('Parent', incrPanel, 'Style', 'text', 'String', 'Initial x:', ...
    'Position', [10, 10, 45, 15], 'HorizontalAlignment', 'left', 'FontSize', 8, ...
    'BackgroundColor', [0.95, 0.95, 0.95]);
initialEdit = uicontrol('Parent', incrPanel, 'Style', 'edit', 'String', '-5', ...
    'Position', [55, 10, 40, 20], 'FontSize', 8);

uicontrol('Parent', incrPanel, 'Style', 'text', 'String', 'Final x:', ...
    'Position', [105, 10, 40, 15], 'HorizontalAlignment', 'left', 'FontSize', 8, ...
    'BackgroundColor', [0.95, 0.95, 0.95]);
finalEdit = uicontrol('Parent', incrPanel, 'Style', 'edit', 'String', '5', ...
    'Position', [145, 10, 40, 20], 'FontSize', 8);

uicontrol('Parent', incrPanel, 'Style', 'text', 'String', 'Step:', ...
    'Position', [195, 10, 30, 15], 'HorizontalAlignment', 'left', 'FontSize', 8, ...
    'BackgroundColor', [0.95, 0.95, 0.95]);
stepEdit = uicontrol('Parent', incrPanel, 'Style', 'edit', 'String', '0.1', ...
    'Position', [225, 10, 40, 20], 'FontSize', 8);

uicontrol('Parent', incrPanel, 'Style', 'text', 'String', 'Tolerance:', ...
    'Position', [275, 10, 50, 15], 'HorizontalAlignment', 'left', 'FontSize', 8, ...
    'BackgroundColor', [0.95, 0.95, 0.95]);
tolEdit = uicontrol('Parent', incrPanel, 'Style', 'edit', 'String', '0.0001', ...
    'Position', [325, 10, 50, 20], 'FontSize', 8);






% Bisection Method parameters
bisectPanel = uipanel('Parent', paramsPanel, 'Position', [0.01, 0.01, 0.98, 0.98], ...
    'BorderType', 'none', 'BackgroundColor', [0.95, 0.95, 0.95], 'Visible', 'off');

uicontrol('Parent', bisectPanel, 'Style', 'text', 'String', 'Lower Bound:', ...
    'Position', [10, 10, 60, 15], 'HorizontalAlignment', 'left', 'FontSize', 8, ...
    'BackgroundColor', [0.95, 0.95, 0.95]);
lowerEdit = uicontrol('Parent', bisectPanel, 'Style', 'edit', 'String', '0', ...
    'Position', [75, 10, 40, 20], 'FontSize', 8);

uicontrol('Parent', bisectPanel, 'Style', 'text', 'String', 'Upper Bound:', ...
    'Position', [125, 10, 65, 15], 'HorizontalAlignment', 'left', 'FontSize', 8, ...
    'BackgroundColor', [0.95, 0.95, 0.95]);
upperEdit = uicontrol('Parent', bisectPanel, 'Style', 'edit', 'String', '5', ...
    'Position', [195, 10, 40, 20], 'FontSize', 8);

uicontrol('Parent', bisectPanel, 'Style', 'text', 'String', 'Tolerance:', ...
    'Position', [245, 10, 50, 15], 'HorizontalAlignment', 'left', 'FontSize', 8, ...
    'BackgroundColor', [0.95, 0.95, 0.95]);
tolBisectEdit = uicontrol('Parent', bisectPanel, 'Style', 'edit', 'String', '0.0001', ...
    'Position', [300, 10, 50, 20], 'FontSize', 8);

uicontrol('Parent', bisectPanel, 'Style', 'text', 'String', 'Max Iter:', ...
    'Position', [360, 10, 45, 15], 'HorizontalAlignment', 'left', 'FontSize', 8, ...
    'BackgroundColor', [0.95, 0.95, 0.95]);
maxIterBisectEdit = uicontrol('Parent', bisectPanel, 'Style', 'edit', 'String', '100', ...
    'Position', [410, 10, 40, 20], 'FontSize', 8);










% Newton-Raphson Method parameters
newtonPanel = uipanel('Parent', paramsPanel, 'Position', [0.01, 0.01, 0.98, 0.98], ...
    'BorderType', 'none', 'BackgroundColor', [0.95, 0.95, 0.95], 'Visible', 'off');

uicontrol('Parent', newtonPanel, 'Style', 'text', 'String', 'Initial Guess:', ...
    'Position', [10, 10, 65, 15], 'HorizontalAlignment', 'left', 'FontSize', 8, ...
    'BackgroundColor', [0.95, 0.95, 0.95]);
initialNewtonEdit = uicontrol('Parent', newtonPanel, 'Style', 'edit', 'String', '1', ...
    'Position', [80, 10, 40, 20], 'FontSize', 8);

uicontrol('Parent', newtonPanel, 'Style', 'text', 'String', 'Search Range:', ...
    'Position', [130, 10, 70, 15], 'HorizontalAlignment', 'left', 'FontSize', 8, ...
    'BackgroundColor', [0.95, 0.95, 0.95]);
finalNewtonEdit = uicontrol('Parent', newtonPanel, 'Style', 'edit', 'String', '5', ...
    'Position', [205, 10, 40, 20], 'FontSize', 8);

uicontrol('Parent', newtonPanel, 'Style', 'text', 'String', 'Tolerance:', ...
    'Position', [255, 10, 50, 15], 'HorizontalAlignment', 'left', 'FontSize', 8, ...
    'BackgroundColor', [0.95, 0.95, 0.95]);
tolNewtonEdit = uicontrol('Parent', newtonPanel, 'Style', 'edit', 'String', '0.0001', ...
    'Position', [310, 10, 50, 20], 'FontSize', 8);

uicontrol('Parent', newtonPanel, 'Style', 'text', 'String', 'Max Iter:', ...
    'Position', [370, 10, 45, 15], 'HorizontalAlignment', 'left', 'FontSize', 8, ...
    'BackgroundColor', [0.95, 0.95, 0.95]);
maxIterNewtonEdit = uicontrol('Parent', newtonPanel, 'Style', 'edit', 'String', '100', ...
    'Position', [420, 10, 40, 20], 'FontSize', 8);












% Regula Falsi Method parameters
regulaPanel = uipanel('Parent', paramsPanel, 'Position', [0.01, 0.01, 0.98, 0.98], ...
    'BorderType', 'none', 'BackgroundColor', [0.95, 0.95, 0.95], 'Visible', 'off');

uicontrol('Parent', regulaPanel, 'Style', 'text', 'String', 'XL (Lower):', ...
    'Position', [10, 10, 60, 15], 'HorizontalAlignment', 'left', 'FontSize', 8, ...
    'BackgroundColor', [0.95, 0.95, 0.95]);
lowerRegulaEdit = uicontrol('Parent', regulaPanel, 'Style', 'edit', 'String', '-1', ...
    'Position', [75, 10, 40, 20], 'FontSize', 8);

uicontrol('Parent', regulaPanel, 'Style', 'text', 'String', 'XU (Upper):', ...
    'Position', [125, 10, 65, 15], 'HorizontalAlignment', 'left', 'FontSize', 8, ...
    'BackgroundColor', [0.95, 0.95, 0.95]);
upperRegulaEdit = uicontrol('Parent', regulaPanel, 'Style', 'edit', 'String', '3', ...
    'Position', [195, 10, 40, 20], 'FontSize', 8);

uicontrol('Parent', regulaPanel, 'Style', 'text', 'String', 'Tolerance:', ...
    'Position', [245, 10, 50, 15], 'HorizontalAlignment', 'left', 'FontSize', 8, ...
    'BackgroundColor', [0.95, 0.95, 0.95]);
tolRegulaEdit = uicontrol('Parent', regulaPanel, 'Style', 'edit', 'String', '0.0001', ...
    'Position', [300, 10, 50, 20], 'FontSize', 8);

uicontrol('Parent', regulaPanel, 'Style', 'text', 'String', 'Max Iter:', ...
    'Position', [360, 10, 45, 15], 'HorizontalAlignment', 'left', 'FontSize', 8, ...
    'BackgroundColor', [0.95, 0.95, 0.95]);
maxIterRegulaEdit = uicontrol('Parent', regulaPanel, 'Style', 'edit', 'String', '100', ...
    'Position', [410, 10, 40, 20], 'FontSize', 8);









% Secant Method parameters
secantPanel = uipanel('Parent', paramsPanel, 'Position', [0.01, 0.01, 0.98, 0.98], ...
    'BorderType', 'none', 'BackgroundColor', [0.95, 0.95, 0.95], 'Visible', 'off');

uicontrol('Parent', secantPanel, 'Style', 'text', 'String', 'X0 (First):', ...
    'Position', [10, 10, 55, 15], 'HorizontalAlignment', 'left', 'FontSize', 8, ...
    'BackgroundColor', [0.95, 0.95, 0.95]);
x0SecantEdit = uicontrol('Parent', secantPanel, 'Style', 'edit', 'String', '0', ...
    'Position', [70, 10, 40, 20], 'FontSize', 8);

uicontrol('Parent', secantPanel, 'Style', 'text', 'String', 'X1 (Second):', ...
    'Position', [120, 10, 65, 15], 'HorizontalAlignment', 'left', 'FontSize', 8, ...
    'BackgroundColor', [0.95, 0.95, 0.95]);
x1SecantEdit = uicontrol('Parent', secantPanel, 'Style', 'edit', 'String', '1', ...
    'Position', [190, 10, 40, 20], 'FontSize', 8);

uicontrol('Parent', secantPanel, 'Style', 'text', 'String', 'Tolerance:', ...
    'Position', [240, 10, 50, 15], 'HorizontalAlignment', 'left', 'FontSize', 8, ...
    'BackgroundColor', [0.95, 0.95, 0.95]);
tolSecantEdit = uicontrol('Parent', secantPanel, 'Style', 'edit', 'String', '0.0001', ...
    'Position', [295, 10, 50, 20], 'FontSize', 8);

uicontrol('Parent', secantPanel, 'Style', 'text', 'String', 'Max Iter:', ...
    'Position', [355, 10, 45, 15], 'HorizontalAlignment', 'left', 'FontSize', 8, ...
    'BackgroundColor', [0.95, 0.95, 0.95]);
maxIterSecantEdit = uicontrol('Parent', secantPanel, 'Style', 'edit', 'String', '100', ...
    'Position', [405, 10, 40, 20], 'FontSize', 8);









% Graphical Method parameters
graphicalPanel = uipanel('Parent', paramsPanel, 'Position', [0.01, 0.01, 0.98, 0.98], ...
    'BorderType', 'none', 'BackgroundColor', [0.95, 0.95, 0.95], 'Visible', 'off');

uicontrol('Parent', graphicalPanel, 'Style', 'text', 'String', 'Plot Range:', ...
    'Position', [10, 10, 60, 15], 'HorizontalAlignment', 'left', 'FontSize', 8, ...
    'BackgroundColor', [0.95, 0.95, 0.95]);
lowerGraphicalEdit = uicontrol('Parent', graphicalPanel, 'Style', 'edit', 'String', '-5', ...
    'Position', [75, 10, 40, 20], 'FontSize', 8);

uicontrol('Parent', graphicalPanel, 'Style', 'text', 'String', 'to', ...
    'Position', [120, 10, 15, 15], 'HorizontalAlignment', 'center', 'FontSize', 8, ...
    'BackgroundColor', [0.95, 0.95, 0.95]);
upperGraphicalEdit = uicontrol('Parent', graphicalPanel, 'Style', 'edit', 'String', '5', ...
    'Position', [140, 10, 40, 20], 'FontSize', 8);

uicontrol('Parent', graphicalPanel, 'Style', 'text', 'String', 'Tolerance:', ...
    'Position', [190, 10, 50, 15], 'HorizontalAlignment', 'left', 'FontSize', 8, ...
    'BackgroundColor', [0.95, 0.95, 0.95]);
tolGraphicalEdit = uicontrol('Parent', graphicalPanel, 'Style', 'edit', 'String', '0.0001', ...
    'Position', [240, 10, 50, 20], 'FontSize', 8);











solveBtn = uicontrol('Style', 'pushbutton', 'String', 'Find All Roots', ...
    'Position', [680, 390, 100, 25], 'Callback', @solveEquation, ...
    'FontSize', 8, 'BackgroundColor', [0.3, 0.6, 0.3], 'ForegroundColor', [1, 1, 1]);




% Results panel 
resultsPanel = uipanel('Title', 'Results', 'Position', [0.01, 0.45, 0.3, 0.19], ...
    'FontSize', 8, 'BackgroundColor', [0.95, 0.95, 0.95]);
resultText = uicontrol('Parent', resultsPanel, 'Style', 'text', ...
    'Position', [10, 10, 220, 90], 'HorizontalAlignment', 'left', ...
    'FontSize', 8, 'BackgroundColor', [0.95, 0.95, 0.95]);





% Plot panel 
plotPanel = uipanel('Title', 'Function Plot', 'Position', [0.32, 0.25, 0.67, 0.39], ...
    'FontSize', 8, 'BackgroundColor', [0.95, 0.95, 0.95]);
plotAxes = axes('Parent', plotPanel, 'Position', [0.1, 0.15, 0.85, 0.8]);





% Table panel 
tablePanel = uipanel('Title', 'Iteration History', 'Position', [0.01, 0.01, 0.98, 0.23], ...
    'FontSize', 8, 'BackgroundColor', [0.95, 0.95, 0.95]);





% Create scrollable table using uitable 
iterationTable = uitable('Parent', tablePanel, ...
    'Position', [10, 10, 770, 120], ...
    'FontSize', 7, ...
    'ColumnName', {'Iteration', 'Xl', 'Δx', 'Xu', 'f(Xl)', 'f(Xu)', 'Product', 'Remark'}, ...
    'ColumnWidth', {60, 80, 80, 80, 80, 80, 80, 220}, ...
    'RowName', [], ...
    'Data', {}, ...
    'BackgroundColor', [1, 1, 1; 0.95, 0.95, 0.95], ...
    'ColumnEditable', false(1, 8), ...
    'Enable', 'on');




% Store handles in figure's UserData 
userData = struct();
userData.eqnEdit = eqnEdit;
userData.resultText = resultText;
userData.plotAxes = plotAxes;
userData.iterationTable = iterationTable; 
userData.currentMethod = 2;
userData.methodGroup = methodGroup;
userData.methodButtons = methodButtons;
userData.solveBtn = solveBtn;



% Parameter panels
userData.incrPanel = incrPanel;
userData.bisectPanel = bisectPanel;
userData.newtonPanel = newtonPanel;
userData.regulaPanel = regulaPanel;
userData.secantPanel = secantPanel;
userData.graphicalPanel = graphicalPanel;



% Parameter controls 
userData.initialEdit = initialEdit;
userData.finalEdit = finalEdit;
userData.stepEdit = stepEdit;
userData.tolEdit = tolEdit;
userData.lowerEdit = lowerEdit;
userData.upperEdit = upperEdit;
userData.tolBisectEdit = tolBisectEdit;
userData.maxIterBisectEdit = maxIterBisectEdit;
userData.initialNewtonEdit = initialNewtonEdit;
userData.finalNewtonEdit = finalNewtonEdit;
userData.tolNewtonEdit = tolNewtonEdit;
userData.maxIterNewtonEdit = maxIterNewtonEdit;
userData.lowerRegulaEdit = lowerRegulaEdit;
userData.upperRegulaEdit = upperRegulaEdit;
userData.tolRegulaEdit = tolRegulaEdit;
userData.maxIterRegulaEdit = maxIterRegulaEdit;
userData.x0SecantEdit = x0SecantEdit;
userData.x1SecantEdit = x1SecantEdit;
userData.tolSecantEdit = tolSecantEdit;
userData.maxIterSecantEdit = maxIterSecantEdit;
userData.lowerGraphicalEdit = lowerGraphicalEdit;
userData.upperGraphicalEdit = upperGraphicalEdit;
userData.tolGraphicalEdit = tolGraphicalEdit;






% Table info 
userData.tablePanel = tablePanel;

set(fig, 'UserData', userData);





% Initial plot
updatePlot();






% Set default method 
set(methodGroup, 'SelectedObject', methodButtons(2)); 



% Store method buttons 
userData.methodButtons = methodButtons;
set(fig, 'UserData', userData);






% trigger 
methodChanged(methodGroup, struct('NewValue', methodButtons(2)));








%% Callback Functions
function methodChanged(source, eventdata)
    userData = get(fig, 'UserData');
    
    
    selectedButton = eventdata.NewValue;
    methodIdx = 1; % Default to first method
    
    
    for i = 1:length(userData.methodButtons)
        if selectedButton == userData.methodButtons(i)
            methodIdx = i;
            break;
        end
    end
    

    userData.currentMethod = methodIdx;
    set(fig, 'UserData', userData);
    
    try
        set(userData.incrPanel, 'Visible', 'off');
        set(userData.bisectPanel, 'Visible', 'off');
        set(userData.newtonPanel, 'Visible', 'off');
        set(userData.regulaPanel, 'Visible', 'off');
        set(userData.secantPanel, 'Visible', 'off');
        set(userData.graphicalPanel, 'Visible', 'off');
    catch

    end
    










    % Show the appropriate parameter panel based on selected method
    switch methodIdx
        case 1 % Graphical Method
            set(userData.graphicalPanel, 'Visible', 'on');
            fprintf('Switched to Graphical Method\n');
        case 2 % Incremental Search
            set(userData.incrPanel, 'Visible', 'on');
            fprintf('Switched to Incremental Search\n');
        case 3 % Bisection Method
            set(userData.bisectPanel, 'Visible', 'on');
            fprintf('Switched to Bisection Method\n');
        case 4 % Newton-Raphson Method
            set(userData.newtonPanel, 'Visible', 'on');
            fprintf('Switched to Newton-Raphson Method\n');
        case 5 % Regula Falsi Method
            set(userData.regulaPanel, 'Visible', 'on');
            fprintf('Switched to Regula Falsi Method\n');
        case 6 % Secant Method
            set(userData.secantPanel, 'Visible', 'on');
            fprintf('Switched to Secant Method\n');
    end
    
    % Update table headers based on method
    updateTableHeaders(methodIdx);
    
    % Force a refresh of the display
    drawnow;
end






function updateTableHeaders(methodIdx)
    userData = get(fig, 'UserData');
    
    % Set new headers and column widths based on method
    switch methodIdx
        case 1 % Graphical Method
            columnNames = {'Iteration', 'x', 'f(x)', 'Status'};
            columnWidths = {60, 100, 100, 500};
        case 2 % Incremental Search
            columnNames = {'Iteration', 'Xl', 'Δx', 'Xu', 'f(Xl)', 'f(Xu)', 'Product', 'Remark'};
            columnWidths = {60, 80, 80, 80, 80, 80, 80, 220};
        case 3 % Bisection Method
            columnNames = {'Root#', 'Iteration', 'Xl', 'Xr', 'Xu', 'f(Xl)', 'f(Xr)', '|Ea|,%', 'Remark'};
            columnWidths = {50, 60, 70, 70, 70, 70, 70, 70, 200};
        case 4 % Newton-Raphson Method
            columnNames = {'Root#', 'Iteration', 'Xi', '|Ea|,%', 'f(Xi)', 'f''(Xi)', 'Remark'};
            columnWidths = {50, 60, 100, 80, 100, 100, 250};
        case 5 % Regula Falsi Method
            columnNames = {'Root#', 'Iteration', 'XL', 'XU', 'XR', '|Ea|,%', 'f(XL)', 'f(XU)', 'f(XR)', 'Remark'};
            columnWidths = {50, 60, 70, 70, 70, 70, 70, 70, 70, 140};
        case 6 % Secant Method
            columnNames = {'Root#', 'Iteration', 'Xi-1', 'Xi', 'Xi+1', '|Ea|,%', 'f(Xi-1)', 'f(Xi)', 'f(Xi+1)', 'Remark'};
            columnWidths = {50, 60, 70, 70, 70, 70, 70, 70, 70, 140};
    end
    
    % Update table properties
    set(userData.iterationTable, 'ColumnName', columnNames);
    set(userData.iterationTable, 'ColumnWidth', columnWidths);
    set(userData.iterationTable, 'Data', {}); % Clear existing data
    set(userData.iterationTable, 'ColumnEditable', false(1, length(columnNames)));
end

function previewFunction(~, ~)
    userData = get(fig, 'UserData');
    eqnStr = get(userData.eqnEdit, 'String');
    
    try
        % Enhanced equation preprocessing for mathematical functions
        processedEqn = preprocessEquation(eqnStr);
        f = str2func(['@(x) ' processedEqn]);
        
        % Test with multiple values including negative
        testVals = [-2, -1, 0, 1, 2];
        testResults = [];
        for i = 1:length(testVals)
            try
                testResults(i) = f(testVals(i));
            catch
                testResults(i) = NaN;
            end
        end
        
        if all(isfinite(testResults))
            msgbox(sprintf('Function preview successful!\nTest values: f(-2)=%.3f, f(-1)=%.3f, f(0)=%.3f, f(1)=%.3f, f(2)=%.3f', ...
                testResults), 'Success', 'help');
        else
            msgbox('Function preview completed with some numerical issues at test points', 'Warning', 'warn');
        end
        
        % Update plot with preview
        updatePlot();
    catch e
        msgbox(['Error: ' e.message], 'Error', 'error');
    end
end

function solveEquation(~, ~)
    userData = get(fig, 'UserData');
    
    % Get input values
    eqnStr = get(userData.eqnEdit, 'String');
    
    % Create function handle with enhanced preprocessing
    try
        processedEqn = preprocessEquation(eqnStr);
        f = str2func(['@(x) ' processedEqn]);
        
        % Test function with multiple values including negative
        testVals = [-1, 0, 1];
        for i = 1:length(testVals)
            testVal = f(testVals(i));
            if ~isfinite(testVal)
                warning('Function may have numerical issues at x=%g', testVals(i));
            end
        end
    catch e
        msgbox(['Error in function: ' e.message], 'Error', 'error');
        return;
    end
    
    % Get selected method
    methodIdx = userData.currentMethod;
    




   
    try
        switch methodIdx
            case 1 % Graphical Method
                a = str2double(get(userData.lowerGraphicalEdit, 'String'));
                b = str2double(get(userData.upperGraphicalEdit, 'String'));
                tol = str2double(get(userData.tolGraphicalEdit, 'String'));
                
                if isnan(a) || isnan(b) || isnan(tol) || a >= b
                    error('Invalid parameter values. Ensure lower < upper bound.');
                end
                
                [roots, history] = graphicalMethodMultiRoot(f, a, b, tol);
                
            case 2 % Incremental Search
                x0 = str2double(get(userData.initialEdit, 'String'));
                xf = str2double(get(userData.finalEdit, 'String'));
                step = str2double(get(userData.stepEdit, 'String'));
                tol = str2double(get(userData.tolEdit, 'String'));
                
                if isnan(x0) || isnan(xf) || isnan(step) || isnan(tol) || step <= 0 || x0 >= xf
                    error('Invalid parameter values. Ensure initial < final and step > 0.');
                end
                
                [roots, history] = incrementalMethodMultiRoot(f, x0, xf, step, tol);
                
            case 3 % Bisection Method
                a = str2double(get(userData.lowerEdit, 'String'));
                b = str2double(get(userData.upperEdit, 'String'));
                tol = str2double(get(userData.tolBisectEdit, 'String'));
                maxIter = str2double(get(userData.maxIterBisectEdit, 'String'));
                
                if isnan(a) || isnan(b) || isnan(tol) || isnan(maxIter) || a >= b
                    error('Invalid parameter values. Ensure lower < upper bound.');
                end
                
                [roots, history] = bisectionMethodMultiRoot(f, a, b, tol, maxIter);
                
            case 4 % Newton-Raphson Method
                x0 = str2double(get(userData.initialNewtonEdit, 'String'));
                searchRange = str2double(get(userData.finalNewtonEdit, 'String'));
                tol = str2double(get(userData.tolNewtonEdit, 'String'));
                maxIter = str2double(get(userData.maxIterNewtonEdit, 'String'));
                
                if isnan(x0) || isnan(searchRange) || isnan(tol) || isnan(maxIter)
                    error('Invalid parameter values.');
                end
                
                % Use initial guess and search range for multi-root Newton-Raphson
                a = x0 - abs(searchRange);
                b = x0 + abs(searchRange);
                [roots, history] = newtonRaphsonMethodMultiRoot(f, a, b, tol, maxIter);
                
            case 5 % Regula Falsi Method
                a = str2double(get(userData.lowerRegulaEdit, 'String'));
                b = str2double(get(userData.upperRegulaEdit, 'String'));
                tol = str2double(get(userData.tolRegulaEdit, 'String'));
                maxIter = str2double(get(userData.maxIterRegulaEdit, 'String'));
                
                if isnan(a) || isnan(b) || isnan(tol) || isnan(maxIter) || a >= b
                    error('Invalid parameter values. Ensure lower < upper bound.');
                end
                
                [roots, history] = regulaFalsiMethodMultiRoot(f, a, b, tol, maxIter);
                
            case 6 % Secant Method
                x0 = str2double(get(userData.x0SecantEdit, 'String'));
                x1 = str2double(get(userData.x1SecantEdit, 'String'));
                tol = str2double(get(userData.tolSecantEdit, 'String'));
                maxIter = str2double(get(userData.maxIterSecantEdit, 'String'));
                
                if isnan(x0) || isnan(x1) || isnan(tol) || isnan(maxIter)
                    error('Invalid parameter values.');
                end
                
                % Use the two initial points to define search range
                a = min(x0, x1) - 2;
                b = max(x0, x1) + 2;
                [roots, history] = secantMethodMultiRoot(f, a, b, tol, maxIter);
        end
        






        % Display results 
        if ~isempty(roots) && any(isfinite(roots))
            validRoots = roots(isfinite(roots));
            validRoots = sort(validRoots); % Sort roots for better display
            
            if length(validRoots) == 1
                resultStr = sprintf('Root found:\nx ≈ %.8f\nf(x) = %.2e', ...
                    validRoots(1), f(validRoots(1)));
            else
                resultStr = sprintf('Found %d roots:\n', length(validRoots));
                for i = 1:length(validRoots)
                    resultStr = [resultStr, sprintf('Root %d: x ≈ %.8f\n', i, validRoots(i))];
                end
                resultStr = [resultStr, sprintf('\nFunction values:\n')];
                for i = 1:length(validRoots)
                    resultStr = [resultStr, sprintf('f(%.4f) = %.2e\n', validRoots(i), f(validRoots(i)))];
                end
            end
        else
            resultStr = 'No roots found in the specified range.\nTry adjusting the search parameters.';
        end
        
        set(userData.resultText, 'String', resultStr);
        
        % Update table
        updateTable(history);
        
        % Update plot with roots
        updatePlot(roots);
        
    catch e
        msgbox(['Calculation error: ' e.message], 'Error', 'error');
        set(userData.resultText, 'String', ['Error: ' e.message]);
    end
end







function updateTable(history)
    userData = get(fig, 'UserData');
    
   
    if ~isempty(history)
        % Convert history to proper table format
        tableData = cell(size(history, 1), size(history, 2));
        
        for i = 1:size(history, 1)
            for j = 1:size(history, 2)
                cellValue = history{i, j};
                
                % Format cell content for display
                if isnumeric(cellValue)
                    if j <= 2 % Iteration or root number
                        tableData{i, j} = sprintf('%d', cellValue);
                    elseif isnan(cellValue)
                        tableData{i, j} = '';
                    else
                        tableData{i, j} = sprintf('%.6f', cellValue);
                    end
                elseif ischar(cellValue) || isstring(cellValue)
                    tableData{i, j} = char(cellValue);
                else
                    tableData{i, j} = '';
                end
            end
        end
        
        % Update table data 
        set(userData.iterationTable, 'Data', tableData);
        
        % Color coding 
        numRows = size(tableData, 1);
        rowColors = repmat([1, 1, 1; 0.95, 0.95, 0.95], ceil(numRows/2), 1);
        rowColors = rowColors(1:numRows, :);
        
        % Highlight 
        for i = 1:numRows
            if size(history, 2) >= 1 && ischar(history{i, end})
                if contains(lower(char(history{i, end})), 'root found') || ...
                   contains(lower(char(history{i, end})), 'converged')
                    rowColors(i, :) = [0.9, 1, 0.9];                 elseif contains(lower(char(history{i, end})), 'sign change')
                    rowColors(i, :) = [1, 1, 0.9]; 
                end
            end
        end
        
        set(userData.iterationTable, 'BackgroundColor', rowColors);
        
       
        if numRows > 6

            drawnow;
        end
    else
       
        set(userData.iterationTable, 'Data', {});
    end
end









function updatePlot(roots)
    userData = get(fig, 'UserData');
    axes(userData.plotAxes);
    
    % Get function
    eqnStr = get(userData.eqnEdit, 'String');
    
    try
        processedEqn = preprocessEquation(eqnStr);
        f = str2func(['@(x) ' processedEqn]);
        
        % Determine plot range 
        if nargin > 0 && ~isempty(roots) && any(isfinite(roots))
            validRoots = roots(isfinite(roots));
            minRoot = min(validRoots);
            maxRoot = max(validRoots);
            range = max(maxRoot - minRoot, 2);
            a = minRoot - range;
            b = maxRoot + range;
        else
            % Get range from 
            methodIdx = userData.currentMethod;
            switch methodIdx
                case 1 % Graphical Method
                    a = str2double(get(userData.lowerGraphicalEdit, 'String'));
                    b = str2double(get(userData.upperGraphicalEdit, 'String'));
                case 2 % Incremental Search
                    a = str2double(get(userData.initialEdit, 'String'));
                    b = str2double(get(userData.finalEdit, 'String'));
                case 3 % Bisection Method
                    a = str2double(get(userData.lowerEdit, 'String'));
                    b = str2double(get(userData.upperEdit, 'String'));
                case 4 % Newton-Raphson Method
                    a = str2double(get(userData.initialNewtonEdit, 'String'));
                    b = str2double(get(userData.finalNewtonEdit, 'String'));
                case 5 % Regula Falsi Method
                    a = str2double(get(userData.lowerRegulaEdit, 'String'));
                    b = str2double(get(userData.upperRegulaEdit, 'String'));
                case 6 % Secant Method
                    a = str2double(get(userData.x0SecantEdit, 'String'));
                    b = str2double(get(userData.x1SecantEdit, 'String'));
                otherwise
                    a = -5;
                    b = 5;
            end
        end
        
      
        if isnan(a) || isnan(b) || a >= b
            a = -5;
            b = 5;
        end
        
       
        range = b - a;
        a = a - 0.1 * range;
        b = b + 0.1 * range;
        
      
        x = linspace(a, b, 1000);
        y = zeros(size(x));
        
        for j = 1:length(x)
            try
                y(j) = f(x(j));
                if ~isfinite(y(j))
                    y(j) = NaN;
                end
            catch
                y(j) = NaN;
            end
        end
        
     
        if any(isfinite(y))
            yFinite = y(isfinite(y));
            yMean = mean(yFinite);
            yStd = std(yFinite);
            outlierThreshold = 5 * yStd;
            
            for j = 1:length(y)
                if isfinite(y(j)) && abs(y(j) - yMean) > outlierThreshold
                    y(j) = NaN;
                end
            end
        end
        










        % Plot function
        cla(userData.plotAxes);
        plot(userData.plotAxes, x, y, 'b-', 'LineWidth', 1.5);
        grid(userData.plotAxes, 'on');
        xlabel(userData.plotAxes, 'x', 'FontSize', 8);
        ylabel(userData.plotAxes, 'f(x)', 'FontSize', 8);
        title(userData.plotAxes, ['f(x) = ' eqnStr], 'FontSize', 9, 'Interpreter', 'none');




        
      
        hold(userData.plotAxes, 'on');
        yLimits = ylim(userData.plotAxes);
        plot(userData.plotAxes, [a, b], [0, 0], 'k--', 'LineWidth', 1);
        
       
        if nargin > 0 && ~isempty(roots)
            validRoots = roots(isfinite(roots));
            colors = ['r', 'g', 'm', 'c', 'y']; 
            
            for i = 1:length(validRoots)
                colorIdx = mod(i-1, length(colors)) + 1;
                
             
                plot(userData.plotAxes, validRoots(i), 0, 'o', ...
                    'Color', colors(colorIdx), 'MarkerSize', 8, ...
                    'MarkerFaceColor', colors(colorIdx), 'LineWidth', 2);
                
              
                labelY = yLimits(2) * 0.1 + (i-1) * (yLimits(2) - yLimits(1)) * 0.05;
                text(userData.plotAxes, validRoots(i), labelY, ...
                    sprintf('x_%d=%.4f', i, validRoots(i)), ...
                    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', ...
                    'FontSize', 7, 'BackgroundColor', [1, 1, 0.8], ...
                    'EdgeColor', colors(colorIdx), 'Color', colors(colorIdx));
            end
        end
        
        hold(userData.plotAxes, 'off');
        




       
        if any(isfinite(y))
            yFinite = y(isfinite(y));
            if ~isempty(yFinite)
                yRange = max(yFinite) - min(yFinite);
                if yRange > 0
                    yPadding = yRange * 0.15;
                    ylim(userData.plotAxes, [min(yFinite) - yPadding, max(yFinite) + yPadding]);
                end
            end
        end
        
    catch e
        cla(userData.plotAxes);
        text(0.5, 0.5, {'Invalid equation or', 'numerical error', e.message}, ...
            'Parent', userData.plotAxes, 'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'middle', 'FontSize', 10, 'Color', 'red');
        set(userData.plotAxes, 'XLim', [0, 1], 'YLim', [0, 1]);
    end
end










function processedEqn = preprocessEquation(eqnStr)
    
    processedEqn = strrep(eqnStr, ' ', '');
    
  
    processedEqn = strrep(processedEqn, '^', '.^');
    
     
    processedEqn = strrep(processedEqn, 'pi', 'pi');
    processedEqn = strrep(processedEqn, 'e', 'exp(1)');
    
   
    processedEqn = regexprep(processedEqn, '(\d)([a-zA-Z\(])', '$1*$2');
    processedEqn = regexprep(processedEqn, '([a-zA-Z\)])(\d)', '$1*$2');
    processedEqn = regexprep(processedEqn, '(\))(\()', '$1*$2');
    
    
    processedEqn = strrep(processedEqn, 'sin(', 'sin(');
    processedEqn = strrep(processedEqn, 'cos(', 'cos(');
    processedEqn = strrep(processedEqn, 'tan(', 'tan(');
    processedEqn = strrep(processedEqn, 'exp(', 'exp(');
    processedEqn = strrep(processedEqn, 'log(', 'log(');
    processedEqn = strrep(processedEqn, 'ln(', 'log(');
    processedEqn = strrep(processedEqn, 'sqrt(', 'sqrt(');
    processedEqn = strrep(processedEqn, 'abs(', 'abs(');
    
    
    processedEqn = strrep(processedEqn, 'asin(', 'asin(');
    processedEqn = strrep(processedEqn, 'acos(', 'acos(');
    processedEqn = strrep(processedEqn, 'atan(', 'atan(');
    
     
    processedEqn = strrep(processedEqn, 'sinh(', 'sinh(');
    processedEqn = strrep(processedEqn, 'cosh(', 'cosh(');
    processedEqn = strrep(processedEqn, 'tanh(', 'tanh(');
end








%Graphical Method

function [roots, history] = graphicalMethodMultiRoot(f, a, b, tol)
    if a >= b
        error('Lower bound must be less than upper bound');
    end
     
    x = linspace(a, b, 5000);
    y = zeros(size(x));

    
    for j = 1:length(x)
        try
            y(j) = f(x(j));
        catch
            y(j) = NaN;
        end
    end

    
    crossings = [];
    for j = 1:length(x)-1
        if isfinite(y(j)) && isfinite(y(j+1)) && y(j) * y(j+1) <= 0 && y(j) ~= y(j+1)
            
            t = -y(j) / (y(j+1) - y(j));
            crossing = x(j) + t * (x(j+1) - x(j));
            crossings(end+1) = crossing;
        end
    end

     
    if ~isempty(crossings)
        crossings = unique(crossings);
        
        refined_crossings = crossings(1);
        for j = 2:length(crossings)
            if abs(crossings(j) - refined_crossings(end)) > tol * 10
                refined_crossings(end+1) = crossings(j);
            end
        end
        crossings = refined_crossings;
    end

   
    if isempty(crossings)
        roots = [];
        history = {1, NaN, NaN, 'No crossings found'};
    else
        roots = crossings;
        history = cell(length(crossings), 4);
        for j = 1:length(crossings)
            try
                fval = f(crossings(j));
            catch
                fval = NaN;
            end
            history(j,:) = {j, crossings(j), fval, sprintf('Root %d found', j)};
        end
    end
end







%Incremental Method
function [roots, history] = incrementalMethodMultiRoot(f, x0, xf, step, tol)
    if step <= 0 || x0 >= xf
        error('Invalid parameters: step must be positive and x0 < xf');
    end
    
    x = x0;
    roots = [];
    history = {};
    iter = 0;
    maxIter = ceil((xf - x0) / step) + 100;  

    while x < xf && iter < maxIter
        iter = iter + 1;
        x_next = min(x + step, xf);  
        
        try
            f_x = f(x);
            f_x_next = f(x_next);
        catch
            x = x_next;
            continue;
        end
        
         
        product = f_x * f_x_next;
        
        if abs(f_x) < tol
            
            if isempty(roots) || abs(x - roots(end)) > tol * 10
                roots(end+1) = x;
                remark = sprintf('Direct root #%d found', length(roots));
            else
                remark = 'Continuing search';
            end
        elseif product < 0
            
            remark = sprintf('Sign change #%d detected', length(roots)+1);
            
            
            a_local = x;
            b_local = x_next;
            for k = 1:25
                mid = (a_local + b_local) / 2;
                try
                    f_mid = f(mid);
                catch
                    break;
                end
                
                if abs(f_mid) < tol
                   
                    if isempty(roots) || min(abs(mid - roots)) > tol * 10
                        roots(end+1) = mid;
                    end
                    break;
                elseif f(a_local) * f_mid < 0
                    b_local = mid;
                else
                    a_local = mid;
                end
            end
            
            if k == 25 && (isempty(roots) || min(abs((a_local + b_local)/2 - roots)) > tol * 10)
                roots(end+1) = (a_local + b_local) / 2;
            end
        else
            remark = 'No sign change';
        end
        
 
        product_str = '<0';
        if product >= 0
            product_str = '>0';
        end
        
        history(end+1,:) = {iter, x, step, x_next, f_x, f_x_next, product_str, remark};
        
        x = x_next;
    end
end




%Bisection Method

function [roots, history] = bisectionMethodMultiRoot(f, a, b, tol, maxIter)
    if a >= b
        error('Lower bound must be less than upper bound');
    end
    
   
    intervals = findSignChangeIntervals(f, a, b, 100);
    
    roots = [];
    history = {};
    
    if isempty(intervals)
        history = {0, a, NaN, b, f(a), NaN, NaN, '>0', 'No sign changes found'};
        return;
    end
    
    
    for rootNum = 1:size(intervals, 1)
        a_local = intervals(rootNum, 1);
        b_local = intervals(rootNum, 2);
        
        try
            fa = f(a_local);
            fb = f(b_local);
        catch
            continue;
        end
        
        if fa * fb > 0
            continue;  
        end
        
        iter = 0;
        c_old = NaN;
        
        while iter < maxIter
            iter = iter + 1;
            
            c = (a_local + b_local) / 2;
            try
                fc = f(c);
            catch
                break;
            end
            
            
            rel_error = NaN;
            if ~isnan(c_old) && c ~= 0
                rel_error = abs((c - c_old) / c) * 100;
            end
            
          
            product = fa * fc;
            if product < 0
                product_str = '<0';
                remark = sprintf('Root %d: 1st subinterval', rootNum);
                b_local = c;
                fb = fc;
            else
                product_str = '>0';
                remark = sprintf('Root %d: 2nd subinterval', rootNum);
                a_local = c;
                fa = fc;
            end
            
         
            history(end+1,:) = {rootNum, iter, a_local, c, b_local, fa, fc, rel_error, remark};
            
           
            if abs(fc) < tol || abs(b_local - a_local) < tol
                roots(end+1) = c;
                history(end,:) = {rootNum, iter, a_local, c, b_local, fa, fc, rel_error, sprintf('Root %d converged', rootNum)};
                break;
            end
            
            c_old = c;
        end
    end
end




%Newton Raphson Method

function [roots, history] = newtonRaphsonMethodMultiRoot(f, a, b, tol, maxIter)
   
    numStartPoints = 10;
    startPoints = linspace(a, b, numStartPoints);
    
    
    h = 1e-8;
    df = @(x) (f(x + h) - f(x - h)) / (2 * h);
    
    roots = [];
    history = {};
    
    for startIdx = 1:length(startPoints)
        x = startPoints(startIdx);
        
      
        if ~isempty(roots) && min(abs(x - roots)) < tol * 50
            continue;
        end
        
        try
            fx = f(x);
            dfx = df(x);
        catch
            continue;
        end
        
       
        for iter = 1:maxIter
            try
                fx = f(x);
                dfx = df(x);
            catch
                break;
            end
            
         
            if abs(dfx) < 1e-12
                history(end+1,:) = {length(roots)+1, iter, x, NaN, fx, dfx, 'Derivative too small'};
                break;
            end
           
            x_new = x - fx / dfx;
            
            
            if x_new < a || x_new > b
                break;
            end
            
           
            rel_error = NaN;
            if x_new ~= 0
                rel_error = abs((x_new - x) / x_new) * 100;
            end
            
            try
                f_new = f(x_new);
                df_new = df(x_new);
            catch
                break;
            end
            
            remark = sprintf('Root %d: Iterating', length(roots)+1);
            if abs(f_new) < tol
               
                if isempty(roots) || min(abs(x_new - roots)) > tol * 10
                    roots(end+1) = x_new;
                    remark = sprintf('Root %d: Converged', length(roots));
                else
                    remark = sprintf('Root %d: Duplicate found', length(roots)+1);
                end
            elseif rel_error < tol * 100
                if isempty(roots) || min(abs(x_new - roots)) > tol * 10
                    roots(end+1) = x_new;
                    remark = sprintf('Root %d: Converged (error)', length(roots));
                end
            end
            
            history(end+1,:) = {length(roots), iter, x_new, rel_error, f_new, df_new, remark};
                 
   
            if abs(f_new) < tol || rel_error < tol * 100
                break;
            end
            
            x = x_new;
        end
    end
end






%Regula Falsi MEthod


function [roots, history] = regulaFalsiMethodMultiRoot(f, a, b, tol, maxIter)
    if a >= b
        error('Lower bound must be less than upper bound');
    end
    
    
    intervals = findSignChangeIntervals(f, a, b, 100);
    
    roots = [];
    history = {};
    
    if isempty(intervals)
        history = {0, a, b, NaN, NaN, f(a), f(b), NaN, '>0', 'No sign changes found'};
        return;
    end
    
   
    for rootNum = 1:size(intervals, 1)
        a_local = intervals(rootNum, 1);
        b_local = intervals(rootNum, 2);
        
        try
            fa = f(a_local);
            fb = f(b_local);
        catch
            continue;
        end
        
        if fa * fb > 0
            continue; 
        end
        
      
        iter = 0;
        c_old = NaN;
        
        while iter < maxIter
            iter = iter + 1;
            
            
            if abs(fb - fa) < 1e-15
                break;
            end
            c = (a_local * fb - b_local * fa) / (fb - fa);
            
            try
                fc = f(c);
            catch
                break;
            end
            
          
            rel_error = NaN;
            if ~isnan(c_old) && c ~= 0
                rel_error = abs((c - c_old) / c) * 100;
            end
            
          
            product = fa * fc;
            if product < 0
                product_str = '<0';
                remark = sprintf('Root %d: 1st subinterval', rootNum);
                b_local = c;
                fb = fc;
            else
                product_str = '>0';
                remark = sprintf('Root %d: 2nd subinterval', rootNum);
                a_local = c;
                fa = fc;
            end
            
            
            history(end+1,:) = {rootNum, iter, a_local, b_local, c, rel_error, fa, fb, fc, remark};
            
          
            if abs(fc) < tol || (~isnan(rel_error) && rel_error < tol * 100)
                roots(end+1) = c;
                history(end,:) = {rootNum, iter, a_local, b_local, c, rel_error, fa, fb, fc, sprintf('Root %d converged', rootNum)};
                break;
            end
            
            c_old = c;
        end
    end
end



%Secant Method

function [roots, history] = secantMethodMultiRoot(f, a, b, tol, maxIter)
    
    numPairs = 8;
    x_vals = linspace(a, b, numPairs + 1);
    
    roots = [];
    history = {};
    
    for pairIdx = 1:numPairs
        x0 = x_vals(pairIdx);
        x1 = x_vals(pairIdx + 1);
        
        
        if ~isempty(roots) && (min(abs(x0 - roots)) < tol * 50 || min(abs(x1 - roots)) < tol * 50)
            continue;
        end
        
        try
            f0 = f(x0);
            f1 = f(x1);
        catch
            continue;
        end
        
      
        for iter = 1:maxIter
           
            if abs(f1 - f0) < 1e-12
                history(end+1,:) = {length(roots)+1, iter, x0, x1, NaN, NaN, f0, f1, NaN, 'Small denominator'};
                break;
            end
            
           
            x2 = x1 - f1 * (x1 - x0) / (f1 - f0);
            
          
            if x2 < a || x2 > b
                break;
            end
            
            try
                f2 = f(x2);
            catch
                break;
            end
            
          
            rel_error = NaN;
            if x2 ~= 0
                rel_error = abs((x2 - x1) / x2) * 100;
            end
            
            remark = sprintf('Root %d: Iterating', length(roots)+1);
            if abs(f2) < tol
               
                if isempty(roots) || min(abs(x2 - roots)) > tol * 10
                    roots(end+1) = x2;
                    remark = sprintf('Root %d: Converged', length(roots));
                else
                    remark = sprintf('Root %d: Duplicate found', length(roots)+1);
                end
            elseif rel_error < tol * 100
                if isempty(roots) || min(abs(x2 - roots)) > tol * 10
                    roots(end+1) = x2;
                    remark = sprintf('Root %d: Converged (error)', length(roots));
                end
            end
            
            history(end+1,:) = {length(roots), iter, x0, x1, x2, rel_error, f0, f1, f2, remark};
            
            
            if abs(f2) < tol || rel_error < tol * 100
                break;
            end
            
           
            x0 = x1;
            f0 = f1;
            x1 = x2;
            f1 = f2;
        end
    end
end


function intervals = findSignChangeIntervals(f, a, b, numPoints)
    x = linspace(a, b, numPoints);
    y = zeros(size(x));
    
   
    for i = 1:length(x)
        try
            y(i) = f(x(i));
        catch
            y(i) = NaN;
        end
    end
    
  
    intervals = [];
    for i = 1:length(x)-1
        if isfinite(y(i)) && isfinite(y(i+1)) && y(i) * y(i+1) < 0
            intervals(end+1, :) = [x(i), x(i+1)];
        end
    end
    
    
    if ~isempty(intervals)
        merged = intervals(1, :);
        for i = 2:size(intervals, 1)
            if intervals(i, 1) <= merged(end, 2)
                merged(end, 2) = max(merged(end, 2), intervals(i, 2));
            else
                merged(end+1, :) = intervals(i, :);
            end
        end
        intervals = merged;
        
       
        range = intervals(:, 2) - intervals(:, 1);
        intervals(:, 1) = intervals(:, 1) - 0.1 * range;
        intervals(:, 2) = intervals(:, 2) + 0.1 * range;
        
        
        intervals(:, 1) = max(intervals(:, 1), a);
        intervals(:, 2) = min(intervals(:, 2), b);
    end
end

end
