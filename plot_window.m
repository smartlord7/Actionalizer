function plot_window(dataset, interval, window_function, fs, window_name)
    t_frame = 0.128; % largura da janela de análise em s
    t_overlap = 0.064; % sobreposiçao das janelas em s
    n_frame = round(t_frame*fs); % número de amostras na janela
    n_overlap = round(t_overlap*fs); % número de amostras sobrepostas na janela

    for k=1:3
        values = dataset(interval, k);
        window = window_function(n_frame); % janela de hamming

        if mod(n_frame, 2)==0
            f_frame = -fs/2:fs/n_frame:fs/2-fs/n_frame;
        else 
            f_frame = -fs/2+fs/(2*n_frame):fs/n_frame:fs/2-fs/(2*n_frame);
        end

        plot(0:n_frame-1,window);
        axis tight;
        xlabel('n');
        title(window_name);

        f_relev = [];
        nframes = 0; % para guardar
        tframes = [];
        N = length(interval);

        for i = 1:n_frame-n_overlap:N-n_frame+1
            % aplicar a janela ao sinal do tempo
            values_frame = values(i:i+n_frame-1).*window;

            % obter a magnitude da fft do sinal
            m_values_frame = abs(fftshift(fft(values_frame)));

            % obter o máximo da magnitude do sinal
            m_values_frame_max = max(m_values_frame);

            % encontrar os índices do máximo da magnitude do sinal
            ind = find(abs(m_values_frame-m_values_frame_max)<0.001);

            % encontrar as frequências correspondentes ao máximo de magnitude
            f_relev = [f_relev, f_frame(ind(2))];

            nframes = nframes+1;

            % calcular o vetor de tempo correspondente a cada janela, que aqui
            % corresponde ao valor do vetor de tempos, t, em cada janela
            t_frame = t(i:i+n_frame-1);
            tframes = [tframes, t_frame(round(n_frame/2)+1)];
        end
        f_relev'    
    end
end