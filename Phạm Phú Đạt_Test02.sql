--Câu 1--
Create table  VatTu
(
 MaVT nvarchar(10) not null primary key,
 TenVT nvarchar(50),
 DVTinh char(10),
 SLCon int 
 )
Create table HDBan
(
 MaHD nvarchar(10) not null primary key,
 HoTenKhach nvarchar(20),
 Ngayxuat date,
 )
Create table Hangxuat
(
 MaHD nvarchar(10)FOREIGN KEY references HDBan(MaHD),
 MaVT nvarchar(10)FOREIGN KEY references VatTu(MaVT),
 DonGia float,
 SLBan int
 )
 

--Câu 2--
select top 1 (slban* dongia) as 'tong tien ', mahd 
 from  hangxuat
 order by [tong tien ] desc


 --Câu 3
  CREATE FUNCTION f3 (
    @MAHD varchar(10)
)
RETURNS TABLE
AS
RETURN
    SELECT 
        HX.MaHD,
        HD.NgayXuat,
        HD.MaVT,
        HX.DonGia,
        HX.SLBan,  
        CASE
            WHEN WEEKDAY(HD.NgayXuat) = 0 THEN N'Thứ hai'            
            WHEN WEEKDAY(HD.NgayXuat) = 1 THEN N'Thứ ba'
            WHEN WEEKDAY(HD.NgayXuat) = 2 THEN N'Thứ tư'
            WHEN WEEKDAY(HD.NgayXuat) = 3 THEN N'Thứ năm'
            WHEN WEEKDAY(HD.NgayXuat) = 4 THEN N'Thứ sáu'
            WHEN WEEKDAY(HD.NgayXuat) = 5 THEN N'Thứ bảy'
            ELSE N'Chủ nhật'
        END AS NGAYTHU
    FROM HangXuat HX
    INNER JOIN HDBan HD ON HX.MAHD = HD.MAHD
    WHERE HX.MAHD = @MAHD;


 --Câu 4--
 CREATE PROCEDURE p4 
@thang int, @nam int 
AS
SELECT 
SUM(SLBan * DonGia)
FROM HangXuat HX
INNER JOIN HDBan HD ON HX.MAHD = HD.MAHD
where MONTH(HD.NgayXuat) = @THANG AND YEAR(HD.NgayXuat) = @NAM;