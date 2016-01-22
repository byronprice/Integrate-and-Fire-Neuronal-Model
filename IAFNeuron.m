function [] = IAFNeuron(alpha,beta,gcinputs)
% IAFNeuron.m
    % INPUT: gcinputs - vector with values alternating as [time to start
    % step input,length of input,strength of input,repeat]
    
    
%     alpha = 1;
%     beta = 0.5;
    E = 2;
    dt = 1/1000;
    totaltime = 10;
    time = 0:dt:totaltime;
    
    gc = zeros(length(time),1);
    
    for i=1:size(gcinputs,1)
        count = 1;
        for t = time
            if t == gcinputs(i,1)
                steps = gcinputs(i,2)/dt;
                mylen = length(count:count+steps);
                gc(count:count+steps,1)=gc(count:count+steps,1)+gcinputs(i,3)*ones(mylen,1);
            end
            count = count+1;
        end
    end
    vthresh = 1;
    reset = 0.0001;
    
    v = zeros(length(time),1);
    spikes = zeros(length(time),1);
    v(1,1) = 0;
    count = 1;
    for i=time
        if i == totaltime
            break;
        end
        v(count+1) = v(count)+dt*(-alpha*v(count)+gc(count)*beta*(E-v(count)));
        if v(count+1) > vthresh
           v(count+1) = reset;
           spikes(count) = 1;
        end
        count = count+1;
    end
    
    subplot(3,1,1)
    plot(time,v,'LineWidth',2)
    ylabel('Membrane Potential')
    title(sprintf('dv/dt = -alpha*v + g*beta*(E-v)         alpha = %0.2f , beta = %0.2f',alpha,beta))
    axis([0 10 0 1.5])
    subplot(3,1,2)
    scatter(time,spikes,'*')
    ylabel('Spike Times')
    subplot(3,1,3)
    plot(time,gc,'LineWidth',2)
    ylabel('Input Conductance')
    xlabel('Time (seconds)')
end
