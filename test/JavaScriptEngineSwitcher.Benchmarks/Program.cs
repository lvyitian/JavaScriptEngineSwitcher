﻿using System.Reflection;

using BenchmarkDotNet.Running;

namespace JavaScriptEngineSwitcher.Benchmarks
{
	public static class Program
	{
		public static void Main(string[] args)
		{
			BenchmarkSwitcher.FromAssembly(typeof(Program).GetTypeInfo().Assembly).Run(args);
		}
	}
}