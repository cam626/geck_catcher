controller = PlayerController();

controller = controller.createRandomBug();
controller = controller.createRandomBug();
controller = controller.createRandomBug();

while true
    controller = controller.updateValues();
    
    bug = controller.bugs(1);
    disp(bug.getPosition());
end