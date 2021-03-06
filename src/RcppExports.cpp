// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// getMessageCountDF
Rcpp::DataFrame getMessageCountDF(std::string filename, int64_t bufferSize, bool quiet);
RcppExport SEXP _RITCH_getMessageCountDF(SEXP filenameSEXP, SEXP bufferSizeSEXP, SEXP quietSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< std::string >::type filename(filenameSEXP);
    Rcpp::traits::input_parameter< int64_t >::type bufferSize(bufferSizeSEXP);
    Rcpp::traits::input_parameter< bool >::type quiet(quietSEXP);
    rcpp_result_gen = Rcpp::wrap(getMessageCountDF(filename, bufferSize, quiet));
    return rcpp_result_gen;
END_RCPP
}
// getOrders_impl
Rcpp::DataFrame getOrders_impl(std::string filename, int64_t startMsgCount, int64_t endMsgCount, int64_t bufferSize, bool quiet);
RcppExport SEXP _RITCH_getOrders_impl(SEXP filenameSEXP, SEXP startMsgCountSEXP, SEXP endMsgCountSEXP, SEXP bufferSizeSEXP, SEXP quietSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< std::string >::type filename(filenameSEXP);
    Rcpp::traits::input_parameter< int64_t >::type startMsgCount(startMsgCountSEXP);
    Rcpp::traits::input_parameter< int64_t >::type endMsgCount(endMsgCountSEXP);
    Rcpp::traits::input_parameter< int64_t >::type bufferSize(bufferSizeSEXP);
    Rcpp::traits::input_parameter< bool >::type quiet(quietSEXP);
    rcpp_result_gen = Rcpp::wrap(getOrders_impl(filename, startMsgCount, endMsgCount, bufferSize, quiet));
    return rcpp_result_gen;
END_RCPP
}
// getTrades_impl
Rcpp::DataFrame getTrades_impl(std::string filename, int64_t startMsgCount, int64_t endMsgCount, int64_t bufferSize, bool quiet);
RcppExport SEXP _RITCH_getTrades_impl(SEXP filenameSEXP, SEXP startMsgCountSEXP, SEXP endMsgCountSEXP, SEXP bufferSizeSEXP, SEXP quietSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< std::string >::type filename(filenameSEXP);
    Rcpp::traits::input_parameter< int64_t >::type startMsgCount(startMsgCountSEXP);
    Rcpp::traits::input_parameter< int64_t >::type endMsgCount(endMsgCountSEXP);
    Rcpp::traits::input_parameter< int64_t >::type bufferSize(bufferSizeSEXP);
    Rcpp::traits::input_parameter< bool >::type quiet(quietSEXP);
    rcpp_result_gen = Rcpp::wrap(getTrades_impl(filename, startMsgCount, endMsgCount, bufferSize, quiet));
    return rcpp_result_gen;
END_RCPP
}
// getModifications_impl
Rcpp::DataFrame getModifications_impl(std::string filename, int64_t startMsgCount, int64_t endMsgCount, int64_t bufferSize, bool quiet);
RcppExport SEXP _RITCH_getModifications_impl(SEXP filenameSEXP, SEXP startMsgCountSEXP, SEXP endMsgCountSEXP, SEXP bufferSizeSEXP, SEXP quietSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< std::string >::type filename(filenameSEXP);
    Rcpp::traits::input_parameter< int64_t >::type startMsgCount(startMsgCountSEXP);
    Rcpp::traits::input_parameter< int64_t >::type endMsgCount(endMsgCountSEXP);
    Rcpp::traits::input_parameter< int64_t >::type bufferSize(bufferSizeSEXP);
    Rcpp::traits::input_parameter< bool >::type quiet(quietSEXP);
    rcpp_result_gen = Rcpp::wrap(getModifications_impl(filename, startMsgCount, endMsgCount, bufferSize, quiet));
    return rcpp_result_gen;
END_RCPP
}
// gunzipFile_impl
void gunzipFile_impl(std::string infile, std::string outfile, int64_t bufferSize);
RcppExport SEXP _RITCH_gunzipFile_impl(SEXP infileSEXP, SEXP outfileSEXP, SEXP bufferSizeSEXP) {
BEGIN_RCPP
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< std::string >::type infile(infileSEXP);
    Rcpp::traits::input_parameter< std::string >::type outfile(outfileSEXP);
    Rcpp::traits::input_parameter< int64_t >::type bufferSize(bufferSizeSEXP);
    gunzipFile_impl(infile, outfile, bufferSize);
    return R_NilValue;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_RITCH_getMessageCountDF", (DL_FUNC) &_RITCH_getMessageCountDF, 3},
    {"_RITCH_getOrders_impl", (DL_FUNC) &_RITCH_getOrders_impl, 5},
    {"_RITCH_getTrades_impl", (DL_FUNC) &_RITCH_getTrades_impl, 5},
    {"_RITCH_getModifications_impl", (DL_FUNC) &_RITCH_getModifications_impl, 5},
    {"_RITCH_gunzipFile_impl", (DL_FUNC) &_RITCH_gunzipFile_impl, 3},
    {NULL, NULL, 0}
};

RcppExport void R_init_RITCH(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
