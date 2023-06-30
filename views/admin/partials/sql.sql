create trigger trg_InsertClassStudent
on dbo.ClassStudent
after inser
as
begin
    update c
    set NumberOfAttendants = NumberOfAttendants + 1
    from dbo.Class c
    join inserted i on c.ClassID = i.ClassID
    where c.NumberOfAttendants < c.MaxCapacity;
end;

--sửa--
create trigger trg_UpdateClassStudent
on dbo.ClassStudent
after update
as
begin
    update c
    SET NumberOfAttendants = NumberOfAttendants + 1
    FROM dbo.Class c
    join inserted i on c.ClassID = i.ClassID
    where c.NumberOfAttendants < c.MaxCapacity;
end;

--xóa--
create trigger trg_DeleteClassStudent
on dbo.ClassStudent
after delete
as
begin
    update c
    set NumberOfAttendants = NumberOfAttendants - 1
    from dbo.Class c
    join deleted d on c.ClassID = d.ClassID;
end;