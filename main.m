controller = PlayerController();
view = ViewController();

t = 0.0;
dt = 1.0 / 60.0;
running = true;

while running
    controller.updateValues(dt);
    view.update(controller);
    t = t + dt;
    
    if t > 60
        running = false;
    end
end