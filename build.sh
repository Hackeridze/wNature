dmd ./src/*.d -O -inline -release -D -ofwNature &&
strip wNature &&
rm *.o &&
mv *.html ./doc
