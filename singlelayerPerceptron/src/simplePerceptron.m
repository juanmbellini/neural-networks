function [w] = simplePerceptron(n, s)

    psi = [ -1, 1, 1;
            -1, 1, -1;
            -1, -1, 1;
            -1, -1, -1];


    w = rand([1 3])-0.5;
    steps = 0;
    o = zeros(1, 4);

    while(1)
        indexes = randperm(4);
        for i = indexes
            o(i) = sign(w*(psi(i,:)'));
            deltaw = n*(s(i)-o(i))*psi(i,:);
            w = w + deltaw;
        end
        steps = steps + 1;
%         disp(o)
        if(s == o)
            s
            steps
            return
        end
    end
end
