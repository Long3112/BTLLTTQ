 use master
 go
 alter database Food_Ind_Management set single_user with rollback immediate
 drop database Food_Ind_Management


CREATE DATABASE Food_Ind_Management
USE [Food_Ind_Management]


-- Bảng khách hàng
CREATE TABLE KhachHang (
  ma_khach NVARCHAR(10),
  ten_khach NVARCHAR(50),
  dia_chi NVARCHAR(50),
  dien_thoai nvarchar(50),
  CONSTRAINT PK_KhachHang PRIMARY KEY (ma_khach) 
);

-- Bảng công dụng
CREATE TABLE CongDung (
  ma_cong_dung NVARCHAR(10) PRIMARY KEY,
  ten_cong_dung NVARCHAR(50)
);

-- Bảng loại món
CREATE TABLE LoaiMon (
  ma_loai NVARCHAR(10) PRIMARY KEY,
  ten_loai NVARCHAR(50)
);

-- Bảng nguyên liệu
CREATE TABLE NguyenLieu (
  ma_nguyen_lieu NVARCHAR(10) PRIMARY KEY,
  ten_nguyen_lieu NVARCHAR(50),
  don_vi_tinh NVARCHAR(50),
  so_luong INT,
  don_gia_nhap MONEY,
  don_gia_ban MONEY,
  cong_dung NVARCHAR(50),
  yeu_cau NVARCHAR(50),
  chong_chi_dinh NVARCHAR(50)
);

-- Bảng nhà cung cấp

CREATE TABLE NhaCungCap (
  ma_nha_cung_cap NVARCHAR(10) PRIMARY KEY,
  ten_nha_cung_cap NVARCHAR(50),
  dia_chi NVARCHAR(50),
  dien_thoai NVARCHAR(50)
);

-- Bảng que
CREATE TABLE Que (
	ma_que NVARCHAR(10) NOT NULL PRIMARY KEY ,
	ten_que NVARCHAR(50)
);
-- Bảng món ăn
CREATE TABLE MonAn	(
  ma_mon_an NVARCHAR(10) PRIMARY KEY,
  ten_mon_an NVARCHAR(50),
  ma_cong_dung NVARCHAR(10),
  ma_loai NVARCHAR(10),
  cach_lam NVARCHAR(50),
  yeu_cau NVARCHAR(50),
  don_gia MONEY,
  CONSTRAINT FK_MonAn_CongDung FOREIGN KEY (ma_cong_dung) REFERENCES CongDung(ma_cong_dung),
  CONSTRAINT FK_MonAn_LoaiMon FOREIGN KEY (ma_loai) REFERENCES LoaiMon(ma_loai)
);

-- Bảng nhân viên
CREATE TABLE NhanVien (
  ma_nhan_vien NVARCHAR(10) NOT NULL,
  ten_nhan_vien NVARCHAR(50) NOT NULL,
  gioi_tinh NVARCHAR(50) NOT NULL,
  ngay_sinh DATE NOT NULL,
  dia_chi NVARCHAR(50) NOT NULL,
  ma_que NVARCHAR(10) NOT NULL,
  CONSTRAINT PK_NhanVien PRIMARY KEY (ma_nhan_vien),
  CONSTRAINT FK_NhanVien_Que FOREIGN KEY (ma_que) REFERENCES Que(ma_que)
);



-- Bảng nguyên liệu món ăn
CREATE TABLE NguyenLieuMonAn (
  ma_mon_an NVARCHAR(10),
  ma_nguyen_lieu NVARCHAR(10),
  so_luong INT,
  CONSTRAINT FK_NguyenLieuMonAn_MonAn FOREIGN KEY (ma_mon_an) REFERENCES MonAn(ma_mon_an),
  CONSTRAINT FK_NguyenLieuMonAn_NguyenLieu FOREIGN KEY (ma_nguyen_lieu) REFERENCES NguyenLieu(ma_nguyen_lieu)
);

-- Bảng phiếu đặt bàn
CREATE TABLE PhieuDatBan (
  ma_phieu NVARCHAR(10) PRIMARY KEY,
  ma_khach NVARCHAR(10),
  ma_nhan_vien NVARCHAR(10),
  ngay_dat DATETIME,
  ngay_dung DATETIME,
  tong_tien MONEY,
  CONSTRAINT FK_PhieuDatBan_KhachHang FOREIGN KEY (ma_khach) REFERENCES KhachHang(ma_khach),
  CONSTRAINT FK_PhieuDatBan_NhanVien FOREIGN KEY (ma_nhan_vien) REFERENCES NhanVien(ma_nhan_vien)
);

-- Bảng chi tiết phiếu đặt bàn
create TABLE ChiTietPhieuDatBan (
  ma_phieu NVARCHAR(10) ,
  ma_mon_an NVARCHAR(10),
  ma_loai NVARCHAR(10),
  so_luong INT,
  giam_gia FLOAT,
  thanh_tien MONEY,
  CONST NVARCHAR(50), -- Định nghĩa kiểu dữ liệu cho cột N'CONSTN'
  CONSTRAINT FK_ChiTietPhieuDatBan_PhieuDatBan FOREIGN KEY (ma_phieu) REFERENCES PhieuDatBan(ma_phieu) ON DELETE CASCADE ,
  CONSTRAINT FK_ChiTietPhieuDatBan_MonAn FOREIGN KEY (ma_mon_an) REFERENCES MonAn(ma_mon_an),
  CONSTRAINT FK_ChiTietPhieuDatBan_LoaiMon FOREIGN KEY (ma_loai) REFERENCES LoaiMon(ma_loai)
);




-- Bảng hóa đơn nhập
CREATE TABLE HoaDonNhap (
  ma_hoa_don_nhap NVARCHAR(10),
  ngay_nhap DATETIME,
  ma_nhan_vien NVARCHAR(10),
  ma_nha_cung_cap NVARCHAR(10),
  tong_tien MONEY,
  CONSTRAINT PK_HoaDonNhap PRIMARY KEY (ma_hoa_don_nhap),
  CONSTRAINT FK_HoaDonNhap_NhanVien FOREIGN KEY (ma_nhan_vien) REFERENCES NhanVien(ma_nhan_vien),
  CONSTRAINT FK_HoaDonNhap_NhaCungCap FOREIGN KEY (ma_nha_cung_cap) REFERENCES NhaCungCap(ma_nha_cung_cap)
);

-- Bảng chi tiết hóa đơn nhập
CREATE TABLE ChiTietHoaDonNhap (
  ma_hoa_don_nhap NVARCHAR(10),
  ma_nguyen_lieu NVARCHAR(10),
  so_luong INT,
  don_gia MONEY,
  khuyen_mai FLOAT,
  thanh_tien MONEY,
  CONSTRAINT PK_ChiTietHoaDonNhap PRIMARY KEY (ma_hoa_don_nhap),
  CONSTRAINT FK_ChiTietHoaDonNhap_HoaDonNhap FOREIGN KEY (ma_hoa_don_nhap) REFERENCES HoaDonNhap(ma_hoa_don_nhap),
  CONSTRAINT FK_ChiTietHoaDonNhap_NguyenLieu FOREIGN KEY (ma_nguyen_lieu) REFERENCES NguyenLieu(ma_nguyen_lieu)
);



INSERT INTO NguyenLieu (ma_nguyen_lieu, ten_nguyen_lieu, don_vi_tinh, so_luong, don_gia_nhap, don_gia_ban, cong_dung, yeu_cau, chong_chi_dinh)
VALUES
( N'1', N'Thịt lợn', N'kg', 100, 50000, 60000, N'Thành phần chính', N'Bảo quản lạnh', N''),
( N'2', N'Bún', N'gói', 200, 10000, 12000, N'Thành phần chính', N'Bảo quản khô ráo', N''),
( N'3', N'Bánh tráng', N'gói', 50, 3000, 3500, N'Thành phần chính', N'Bảo quản khô ráo', N''),
( N'4', N'Gà tươi', N'kg', 80, 60000, 70000, N'Thành phần chính', N'Bảo quản lạnh', N'');

INSERT INTO LoaiMon (ma_loai, ten_loai)
VALUES
(N'1', N'Món chính'),
(N'2', N'Món khai vị'),
(N'3', N'Món tráng miệng'),
(N'4', N'Món nước');


INSERT INTO Que (ma_que, ten_que)
VALUES
(N'1', N'Hà Nội'),
(N'2', N'Hồ Chí Minh'),
(N'3', N'Đà Nẵng'),
(N'4', N'Hải Phòng');

INSERT INTO NhanVien (ma_nhan_vien, ten_nhan_vien, gioi_tinh, ngay_sinh, dia_chi, ma_que)
VALUES
(N'1', N'Nguyen Van A', N'Nam', N'1990-01-15', N'123 Đường ABC, Quận 1', N'1'),
(N'2', N'Tran Thi B', N'Nữ', N'1995-05-20', N'456 Đường XYZ, Quận 2', N'2'),
(N'3', N'Hoang Van C', N'Nam', N'1985-08-10', N'789 Đường MNO, Quận 3', N'3'),
(N'4', N'Le Thi D', N'Nữ', N'1992-12-25', N'101 Đường DEF, Quận 4', N'4');

-- Bảng nhà cung cấp
INSERT INTO NhaCungCap (ma_nha_cung_cap, ten_nha_cung_cap, dia_chi, dien_thoai)
VALUES
(N'1', N'Công ty TNHH A', N'123 Đường ABC, Quận 1', N'0368730819'),
(N'2', N'Công ty TNHH B', N'456 Đường XYZ, Quận 2', N'0986647899'),
(N'3', N'Công ty TNHH C', N'789 Đường MNO, Quận 3', N'0122232568'),
(N'4', N'Công ty TNHH D', N'101 Đường DEF, Quận 4', N'0896555678');


INSERT INTO HoaDonNhap (ma_hoa_don_nhap, ngay_nhap, ma_nhan_vien, ma_nha_cung_cap, tong_tien)
VALUES
(N'1', N'2023-10-01 09:00:00', N'1', N'1', N'5000000'),
(N'2', N'2023-10-02 14:30:00', N'2', N'2', N'7000000'),
(N'3', N'2023-10-03 11:15:00', N'3', N'3', N'6000000'),
(N'4', N'2023-10-04 16:45:00', N'4', N'4', N'8000000');

INSERT INTO KhachHang (ma_khach, ten_khach, dia_chi, dien_thoai)
VALUES
(N'1', N'Nguyen Van X', N'123 Đường GHI, Quận 5', N'555666777'),
(N'2', N'Tran Thi Y', N'456 Đường JKL, Quận 6', N'888999000'),
(N'3', N'Hoang Van Z', N'789 Đường PQR, Quận 7', N'111222333'),
(N'4', N'Le Thi W', N'101 Đường STU, Quận 8', N'999888777');

INSERT INTO PhieuDatBan (ma_phieu, ma_khach, ma_nhan_vien, ngay_dat, ngay_dung, tong_tien)
VALUES
(N'1', N'1', N'1', N'2023-10-05 18:30:00', N'2023-10-05 20:00:00', N'405000'),
(N'2', N'2', N'2', N'2023-10-06 19:00:00', N'2023-10-06 21:00:00', N'480000');

INSERT INTO CongDung (ma_cong_dung, ten_cong_dung)
VALUES
(N'1', N'Bổ dưỡng'),
(N'2', N'Giảm cân'),
(N'3', N'Trị bệnh'),
(N'4', N'Làm đẹp');


INSERT INTO MonAn (ma_mon_an, ten_mon_an, ma_cong_dung, ma_loai, cach_lam, yeu_cau, don_gia)
VALUES
(N'1', N'Bún chả', N'1', N'1', N'Nướng than củi', N'Không', N'90000'),
(N'2', N'Gỏi cuốn', N'2', N'2', N'Cuốn bằng bánh tráng', N'Không', N'75000'),
(N'3', N'Phở bò', N'1', N'1', N'Nấu lửa lớn', N'Không', N'120000'),
(N'4', N'Gà nướng', N'2', N'2', N'Nướng trên lửa than', N'Không', N'150000');
INSERT INTO chitiethoadonnhap(  ma_hoa_don_nhap ,ma_nguyen_lieu ,so_luong,don_gia,khuyen_mai ,thanh_tien)
VALUES
(N'1', N'1', 10, 100.50, 0.1, 1005.00),
    (N'2', N'2', 5, 50.25, 0.05, 251.25),
    (N'3', N'3', 6, 60.30, 0.2, 1218.60),
    (N'4', N'4', 7, 70.35, 0.15, 1234.45);



INSERT INTO NguyenLieuMonAn (ma_mon_an, ma_nguyen_lieu, so_luong)
VALUES
(N'1', N'1',10),
(N'1', N'2', 5),
(N'2', N'3', 20),
(N'3', N'4', 15);

	
	INSERT INTO ChiTietPhieuDatBan (ma_phieu, ma_mon_an, ma_loai, so_luong, giam_gia, thanh_tien)
VALUES
    (N'1', N'1', N'1', 10, 0.1, 100.50),
    (N'2', N'2', N'2', 5, 0.05, 50.25);


/*1. Số lượng trong bảng Nguyên liệu được tự động cập nhật khi nhập nguyên vật liệu và đặt món ăn:
*/
CREATE or alter TRIGGER UpdateSoLuongNguyenLieu
ON ChiTietHoaDonNhap
AFTER INSERT
AS
BEGIN
    UPDATE NguyenLieu
    SET so_luong = NguyenLieu.so_luong + inserted.so_luong
    FROM NguyenLieu
    INNER JOIN inserted ON NguyenLieu.ma_nguyen_lieu = inserted.ma_nguyen_lieu;
END;
/*
2. Giá nhập trong bảng Nguyên liệu được tự động cập nhật khi nhập hàng:
*/
CREATE or alter TRIGGER UpdateGiaNhapNguyenLieu
ON ChiTietHoaDonNhap
AFTER INSERT
AS
BEGIN
    UPDATE NguyenLieu
    SET don_gia_nhap = inserted.don_gia
    FROM NguyenLieu
    INNER JOIN inserted ON NguyenLieu.ma_nguyen_lieu = inserted.ma_nguyen_lieu;
END;
/*
3. Giá bán trong bảng Nguyên liệu được tự động cập nhật = 100% Giá nhập:
*/
CREATE or alter TRIGGER UpdateGiaBanNguyenLieu
ON NguyenLieu
AFTER UPDATE
AS
BEGIN
    UPDATE NguyenLieu
    SET don_gia_ban = inserted.don_gia_nhap * 1.0
    FROM NguyenLieu
    INNER JOIN inserted ON NguyenLieu.ma_nguyen_lieu = inserted.ma_nguyen_lieu;
END;
/*
4. Đơn giá trong bảng Món ăn được tính bằng tổng tiền của các nguyên vật liệu làm lên món ăn đó:
*/
CREATE or alter TRIGGER UpdateDonGiaMonAn
ON NguyenLieuMonAn
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE MonAn
    SET don_gia = (
        SELECT SUM(NguyenLieu.don_gia_ban * NguyenLieuMonAn.so_luong)
        FROM NguyenLieu
        INNER JOIN NguyenLieuMonAn ON NguyenLieu.ma_nguyen_lieu = NguyenLieuMonAn.ma_nguyen_lieu
        WHERE NguyenLieuMonAn.ma_mon_an = MonAn.ma_mon_an
    )
    FROM MonAn
    INNER JOIN inserted ON MonAn.ma_mon_an = inserted.ma_mon_an
    INNER JOIN deleted ON MonAn.ma_mon_an = deleted.ma_mon_an;
END;






create or alter view QuanLyPhieuDatBan
as
select PhieuDatBan.ma_khach,PhieuDatBan.ma_nhan_vien,PhieuDatBan.ngay_dat,PhieuDatBan.ngay_dung,ten_mon_an,so_luong,tong_tien
from PhieuDatBan
join ChiTietPhieuDatBan on ChiTietPhieuDatBan.ma_phieu=PhieuDatBan.ma_phieu
join MonAn on ChiTietPhieuDatBan.ma_mon_an=MonAn.ma_mon_an
join NhanVien on NhanVien.ma_nhan_vien=PhieuDatBan.ma_nhan_vien
join KhachHang on KhachHang.ma_khach=PhieuDatBan.ma_khach
select * from QuanLyPhieuDatBan
INSERT INTO NguyenLieu (ma_nguyen_lieu, ten_nguyen_lieu, don_vi_tinh, so_luong, don_gia_nhap, don_gia_ban, cong_dung, yeu_cau, chong_chi_dinh)
VALUES
( N'1', N'Thịt lợn', N'kg', 100, 50000, 60000, N'Thành phần chính', N'Bảo quản lạnh', N'')
select * from PhieuDatBan
select * from ChiTietPhieuDatBan

INSERT INTO PhieuDatBan (ma_phieu, ma_khach, ma_nhan_vien, ngay_dat, ngay_dung, tong_tien)
VALUES
(N'99', N'1', N'1', N'2022-10-05 18:30:00', N'2022-10-10 20:00:00', N'355000')

INSERT INTO KhachHang (ma_khach, ten_khach, dia_chi, dien_thoai)
VALUES
(N'5', N'Nguyen Van X', N'123 Đường GHI, Quận 5', N'555666777')

INSERT INTO NhanVien (ma_nhan_vien, ten_nhan_vien, gioi_tinh, ngay_sinh, dia_chi, ma_que)
VALUES
(N'5', N'Nguyen Van A', N'Nam', N'1990-01-15', N'123 Đường ABC, Quận 1', N'1')

	INSERT INTO ChiTietPhieuDatBan (ma_phieu, ma_mon_an, ma_loai, so_luong, giam_gia, thanh_tien)
VALUES
    (N'5', N'1', N'1', 10, 0.1, 100.50)
	INSERT INTO MonAn (ma_mon_an, ten_mon_an, ma_cong_dung, ma_loai, cach_lam, yeu_cau, don_gia)
VALUES
(N'1', N'Bún chả', N'1', N'1', N'Nướng than củi', N'Không', N'90000'),
delete from PhieuDatBan where ma_phieu=N'11'
select * from PhieuDatBan
select * from ChiTietPhieuDatBan

update PhieuDatBan set ma_phieu=N'8',ma_khach=N'2',ma_nhan_vien=N'2',ngay_dat=N'2022-10-05 18:30:00',ngay_dung=N'2022-10-10 20:00:00',tong_tien=N'355000'

INSERT INTO PhieuDatBan (ma_phieu, ma_khach, ma_nhan_vien, ngay_dat, ngay_dung, tong_tien)
VALUES
(N'99', N'1', N'1', N'2022-10-05 18:30:00', N'2022-10-10 20:00:00', N'355000')
update MonAn set ten_mon_an = N'" + txttenmonan.Text + "', ma_cong_dung=N'" + txtcongdung.Text + "', ma_loai=N'" + txtloai.Text + "', cach_lam=N'" + txtcachlam.Text + "', yeu_cau=N'" + txtyeucau.Text + "' where ma_mon_an='" + txtmamonan.Text + "';




