
DECLARE @BoolType bit = 1
DECLARE @IntType int = 12345
DECLARE @StringType nvarchar(400) = ' fsdf sdf sdf sdfasdf sadf sad fsd fasdfs dfsdf adf sad f'
DECLARE @DateTimeType datetime = '01/01/2015 23:59:59.999'
DECLARE @DateTimeOffsetType datetimeoffset = '2012-10-25 12:24:32 +10:0'
DECLARE @TimeType time = '12:34:54.1237'
DECLARE @GuidType uniqueidentifier = '0E984725-C51C-4BF4-9960-E1C80E27ABA0'


declare @i int = 1
declare @rows_to_insert int = 18

while @i <= @rows_to_insert
    begin
    INSERT INTO dbo.Employees(BoolType, IntType, StringType, DateTimeType, DateTimeOffsetType, TimeType, GuidType) 
    VALUES (@BoolType, @IntType, @StringType, @DateTimeType, @DateTimeOffsetType, @TimeType, @GuidType)

    set @i = @i + 1
    end

declare @i1 int = 1
declare @rows_to_insert1 int = 18

while @i1 <= @rows_to_insert1
    begin
    INSERT INTO dbo.TestTable(BoolType, IntType, StringType, DateTimeType, DateTimeOffsetType, TimeType, GuidType) 
    VALUES (@BoolType, @IntType, @StringType, @DateTimeType, @DateTimeOffsetType, @TimeType, @GuidType)

    set @i1 = @i1 + 1
    end


--18 groups--

insert into dbo.Groups(Name,Description) values
('BoolType row', ''),
('IntType row', ''),
('StringType row', ''),
('DateTimeType row', ''),
('DateTimeOffsetType row', ''),
('TimeType row', ''),
('GuidType row', ''),
('BoolType row and context', ''),
('IntType row and context', ''),
('StringType row and context', ''),
('DateTimeType row and context', ''),
('DateTimeOffsetType row and context', ''),
('TimeType row and context', ''),
('GuidType row and context', ''),
('row and context 7', ''),
('row and context 14', ''),
('row and context 21', ''),
('row and context 28', '')


declare @i2 int = 1
declare @rows_to_insert2 int = 18

while @i2 <= @rows_to_insert2
    begin
    INSERT INTO dbo.EmployeeGroups(EmployeeId, GroupId) VALUES 
    (@i2, @i2)

    set @i2 = @i2 + 1
    end

declare @condition7 nvarchar(1000) = 'R.BoolType = C.BoolType and R.IntType = C.IntType and R.StringType = C.StringType and R.DateTimeType = C.DateTimeType and R.DateTimeType = C.DateTimeType and R.GuidType = C.GuidType'

declare @condition14 nvarchar(1000) = CONCAT(@condition7, ' and ', @condition7)

declare @condition21 nvarchar(1000) = CONCAT(@condition7, ' and ', @condition7, ' and ', @condition7)

declare @condition28 nvarchar(1000) = CONCAT(@condition7, ' and ', @condition7, ' and ', @condition7, ' and ', @condition7)

insert into dbo.Predicates(TableName, Value) values
('dbo.TestTable', 'R.BoolType = true as bool'),
('dbo.TestTable', 'R.IntType = 12345'),
('dbo.TestTable', 'R.StringType = "fsd fdsf sdf sdfsdf s"'),
('dbo.TestTable', 'R.DateTimeType = "01/01/2015" as datetime'),
('dbo.TestTable', 'R.DateTimeOffsetType = "4/3/2007 2:23:57 AM" as datetimeoffset'),
('dbo.TestTable', 'R.TimeType = "12:12:12" as timespan'),
('dbo.TestTable', 'R.GuidType = "0E984725-C51C-4BF4-9960-E1C80E27ABA0" as guid'),

('dbo.TestTable', 'R.BoolType = C.BoolType'),
('dbo.TestTable', 'R.IntType = C.IntType'),
('dbo.TestTable', 'R.StringType = C.StringType'),
('dbo.TestTable', 'R.DateTimeType = C.DateTimeType'),
('dbo.TestTable', 'R.DateTimeOffsetType = C.DateTimeOffsetType'),
('dbo.TestTable', 'R.DateTimeType = C.DateTimeType'),
('dbo.TestTable', 'R.GuidType = C.GuidType'),

('dbo.TestTable', @condition7),
('dbo.TestTable', @condition14),
('dbo.TestTable', @condition21),
('dbo.TestTable', @condition28)


declare @i3 int = 1
declare @rows_to_insert3 int = 18

while @i3 <= @rows_to_insert3
    begin
    INSERT INTO dbo.Policies(GroupId, PredicateId) VALUES 
    (@i3, @i3)

    set @i3 = @i3 + 1
    end
