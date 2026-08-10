

use beautysalondb
go 

DECLARE @ServiceName NVARCHAR(50);
DECLARE @TotalReservations INT;
DECLARE @TotalIncome DECIMAL(10,2);

DECLARE ServiceReportCursor CURSOR FOR

SELECT
    s.name,
    COUNT(rs.reservation_id) AS TotalReservations,
    COUNT(rs.reservation_id) * s.price AS TotalIncome
FROM Service s
LEFT JOIN Reservation_Service rs
    ON s.id = rs.service_id
GROUP BY s.name, s.price;

OPEN ServiceReportCursor;

FETCH NEXT FROM ServiceReportCursor
INTO @ServiceName, @TotalReservations, @TotalIncome;

WHILE @@FETCH_STATUS = 0
BEGIN

    SELECT
        @ServiceName AS ServiceName,
        @TotalReservations AS ReservationCount,
        @TotalIncome AS TotalIncome;

    FETCH NEXT FROM ServiceReportCursor
    INTO @ServiceName, @TotalReservations, @TotalIncome;
END

CLOSE ServiceReportCursor;
DEALLOCATE ServiceReportCursor;