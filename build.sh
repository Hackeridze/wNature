dmd ./src/*.d -O -inline -release -D -ofwNature &&
rm *.o &&
mv *.html ./doc
