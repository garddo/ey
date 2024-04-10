%% Koordinat Awal x dan y
xt=0; %Sumbu x
yt=3.25; %Sumbu y
%% Desain Sistem
L=5; %Panjang Roda L dengan R
theta=0; %Untuk Nilai Theta
%% Definisi Sistem
f = [0 ; 0];
g = [1 0; 0 1];
x1 = -4;
x2 = 3;
%% Pembuatan figure
figure;
grid on;
hold on;
plot(0,0,'w.');
%% Definisi fungsi lyapunov
Vf = 0;
Vg = [x1 x2];
%% Pembuatan visualisasi jalur
th = 0:pi/50:2*pi;
r=3.25;
xunit = r * cos(th);
yunit = r * sin(th);
h = plot(xunit, yunit);
%% main code
i = 0;
for i = 1:1000
    rplot=plot(x1,x2,'rX','linewidth',8);
    bplot=plot(xt,yt,'b>','linewidth',4); %Plotting (Panah) Pada Persamaan xt dan yt
    %% Lyapunov
    xr = r*cos(i*2*pi/100+pi);
    %negatif untuk bergerak searah jarum jam positif untuk berlawanan
    yr = -r*sin(i*2*pi/100+pi);
    %Update lyapunov agar tracking
    Vg = [(x1-xr) (x2-yr)];
    %% Pergerakan Barrier
    vL=0.25/2;
    vR=0.125/8;
    %Mengubah kecepatan jadi posisi
    w=(vR-vL)/L; %Rumus Kecepatan Sudut
    v=(vR+vL)/2; %Rumus Kecepatan Roda 
    xt=xt+v*cos(theta+w); %Persamaan Pada xt
    yt=yt+v*sin(theta+w); %Persamaan Pada yt
    theta=theta+w; %Rumus Theta
    %% Barrier
    %jarak antara penghalang dengan agen
    l=sqrt((x1-xt)^2+(x2-yt)^2);
    %parameter CBF
    sig=0.5;
    lam=2;
    %Fungsi CBF
    B=lam*exp(-l^2/sig)*[-2*(x1-xt) -2*(x2-yt)]
    %% Gabungan
    a=Vf;
    b=Vg+B;
    %Sontag's universal formula
    if (b(1)~=0||b(2)~=0)
        k=-(a+sqrt(a^2+b.^4))./(b.*(1+sqrt(1+b.^2)));
    else
        k=[0 0];
    end
    %integral
    x1 = x1+k(1);
    x2 = x2+k(2);
    %% Persiapan siklus baru
    pause(0.05);
    delete(rplot);
    delete(bplot);
end