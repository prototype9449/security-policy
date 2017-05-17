﻿using System;
using System.Data.Sql;
using Microsoft.SqlServer.Server;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Diagnostics;
using System.Linq;

public class ContextParser
{
    public class Tuple
    {
        public Tuple(string variable, string value)
        {
            Variable = variable;
            Value = value;
        }
        public string Variable { get; set; }
        public string Value { get; set; }
    }

    [SqlFunction(DataAccess = DataAccessKind.Read)]
    public static bool ExecutePredicate(string predicate, string rowValue)
    {
        var predicates = predicate.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
        var predicateTuples = new List<Tuple>();
        foreach (var pred in predicates)
        {
            var values = pred.Split(new[] { '=', ' ' }, StringSplitOptions.RemoveEmptyEntries);
            predicateTuples.Add(new Tuple(values[0], values[1]));
        }
        var rowValues = rowValue.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
        var rowTuples = new List<Tuple>();
        foreach (var value in rowValues)
        {
            var values = value.Split(new[] { '=', ' ' }, StringSplitOptions.RemoveEmptyEntries);
            rowTuples.Add(new Tuple(values[0], values[1].Trim('"')));
        }

        var contextDict = predicateTuples.Where(x => x.Value.IndexOf('"') == -1).ToDictionary(t => t.Value, y => "");
        var rowDict = rowTuples.ToDictionary(x => x.Variable, y => y.Value);

        var contextQuery = "select " + string.Join(", ", contextDict.Keys.Select(x => string.Format("SESSION_CONTEXT(N'{0}') as {0}", x)));
        if (contextDict.Keys.Count != 0)
        {
            using (SqlConnection connection = new SqlConnection("context connection=true"))
            {
                SqlCommand cmd = new SqlCommand();
                SqlDataReader reader;

                cmd.CommandText = contextQuery;
                cmd.CommandType = CommandType.Text;
                cmd.Connection = connection;
                cmd.Connection.Open();
                reader = cmd.ExecuteReader();

                try
                {
                    while (reader.Read())
                    {
                        contextDict = contextDict.Keys.ToDictionary(x => x, y => reader[y].ToString());                        
                    }
                }
                finally
                {                    
                    cmd.Connection.Close();
                    reader.Close();
                }
            }
        }


        foreach (var keyValue in predicateTuples)
        {
            var key = "";
            if (keyValue.Variable.IndexOf('"') == -1)
            {
                key = rowDict[keyValue.Variable];
            }
            else
            {
                key = keyValue.Variable.Trim('"');
            }
            var value = "";
            if (keyValue.Value.IndexOf('"') == -1)
            {
                value = contextDict[keyValue.Value];
            }
            else
            {
                value = keyValue.Value.Trim('"');
            }

            if (key != value)
            {
                return false;
            }

        }

        return true;
    }
}